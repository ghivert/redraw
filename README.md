# Redraw

React opinionated bindings for Gleam. Use React directly from Gleam, with a
friendly API that will never get in your way. Redraw tries to stick to React
conventions, while providing idiomatic Gleam code. Write interoperable code
between React and Gleam, reuse existing components, and leverage type-safe
components & immutable data structure. Forget runtime errors, and write
production-grade React components that just work.

## Before you begin

Gleam developers come from different horizons, some from JavaScript, some from
the BEAM, and the rest from various backgrounds, like Go, Python, or Java. While
Gleam is a user-friendly language that helps you make the right decisions, and
Redraw embraces this philosophy by simplifying things as much as possible.
However, some prior knowledge of frontend development is required.

Being a suite of React-bindings, Redraw assumes you know how React works and how
to write an application. Redraw does not help you to begin your journey in
frontend development, and sometimes requires you to write JavaScript code and to
understand how to connect existing React components. If you don't know what NPM
is, what is a Single-Page Application, or how to use Vite, there's a chance
you'll need to learn all of this before jumping into Redraw! If you don't feel
experienced enough in frontend development, you could take a look at
[Lustre](https://lustre.build). In contrast to Redraw, Lustre requires little to
no knowledge of JavaScript, Lustre does not require you to manage your runtimes
like Node.js, and will help you to build your dream application with HTML/CSS
and other web technologies! \
As a plus, Lustre is supported by the entire Gleam community! Lustre is
user-friendly and focused on providing the best developer experience, right
out-of-the-box! In case you're hesitant between jumping into Redraw or starting
Lustre, try the latter.

If, despite all of this, you don't feel comfortable with frontend development,
but still _need_ to use React (for work for example), don't worry! Redraw will
be there to support you.
[Start by reading the documentation](https://react.dev/), and
[follow the amazing tutorials made by the React team](https://react.dev/learn/tutorial-tic-tac-toe).
Before you know it, you'll get comfortable with React, components and Redraw,
and you'll be able building great applications!

## Overview

Redraw is a package that lets you use React in a frontend-only Gleam project. By
leveraging the entire JS ecosystem, Redraw helps you interop with existing
current React codebases, or allows you to build your custom codebase and
cherry-picking the existing components you know and love! Redraw tries to stick
with the React runtime and API, in order to let you reuse your existing React
knowledge. Every skill used in React can be used in Redraw, and vice-versa.
Wherever possible, Redraw also tries to stick with the Lustre API, once again to
let you reuse your existing skills between Redraw and Lustre across different
projects, or to help you migrating to Redraw from Lustre or from Lustre to
Redraw.

## Prerequisites

Redraw assumes you have [`node.js`](https://nodejs.org/en) or equivalent as well
as a modern package manager, i.e. `npm`, `yarn`, `pnpm`, or even `bun`. Redraw
also assumes you're using [`Vite`](https://vitejs.dev/) or an equivalent as a
build tool, and will not provide any interface to build your application. In the
rest of this README, `Vite` will be used as an example. It's up to you to use
another bundler if you prefer. Redraw sticks with the modern, up-to-date
frontend stack.

## Getting started

Create the project, and add everything needed to make it work. Choose your
preferred bundler to start. Create a Vite application, and choose to use
JavaScript/TypeScript and React. Vite should bundle everything for you directly.

```sh
npm create vite@latest
```

```sh
yarn create vite
```

```sh
pnpm create vite
```

```sh
bun create vite
```

From now on, `yarn` will be used to illustrate the commands, it's up to you to
see how to use your desired package manager. Then, it's time to set up the
project correctly.

```sh
cd [project-name]
yarn install

# Install the Vite Gleam plugin. That plugin is required to tell Vite how to
# read Gleam files.
yarn add -D vite-gleam

# If you want to build the project on Vercel or Netlify.
# @chouquette/gleam provides a local version of the Gleam compiler installed in
# your node_modules. You can freely skip that step if you don't need to build
# your application remotely or if you're in control of the environment.
yarn add -D @chouquette/gleam

# Remove the files needed for `gleam new` to work.
mv README.md README.md.old
mv .gitignore .gitignore.old

# Set up the project.
gleam new .
gleam add redraw redraw_dom
```

Now that everything is set up, you need to add the `vite-gleam` plugin in
`vite.config.js`. An example of a `vite.config.js` should look like this.

```javascript
import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import gleam from "vite-gleam"

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), gleam()],
})
```

You're good to go!

## Writing Redraw components

Writing Redraw components is the same as writing React components, with one
small difference: wrap the component in `use props <- redraw.component_()`!

```gleam
import redraw
import redraw/dom/attribute
import redraw/dom/html

pub fn gleam_is_awesome() {
  use Nil <- redraw.component_("GleamIsAwesome")
  html.div([attribute.class("oh-yeah")], [
    html.text("Yeah, for sure")
  ])
}
```

While this might feel strange at first, you'll get used to it quickly. To call
the component, you'll need to compose it in your component. In order to compose
it, you need to call `redraw.compose` _before defining a new component_. This
process "creates" every component in a Redraw application at startup, during
what is called a "bootstrap phase".

```gleam
import redraw
import redraw/dom/attribute
import redraw/dom/client
import redraw/dom/html

pub fn main() {
  let assert Ok(root) = client.create_root("root")
  client.render(root, redraw.strict_mode([app()]))
}

fn app() {
  // Compose `gleam_is_awesome` here, before component creation,
  // during the bootstrap phase.
  use gleam_is_awesome <- redraw.compose(gleam_is_awesome())
  use Nil <- redraw.component_("Root")
  html.div([], [
    gleam_is_awesome(Nil)
  ])
}

fn gleam_is_awesome() {
  use Nil <- redraw.component_("GleamIsAwesome")
  html.div([attribute.class("oh-yeah")], [
    html.text("Yeah, for sure")
  ])
}
```

And you know everything to create Redraw components!

## `Element`, `Component` and passing props

React has two main built-in notions: elements and components. In React, an
element is a part of the UI, and is the result of components renders. For
example, a `<div>` is an element, but the execution of a `Counter` is also an
element. On the other hand, a component is a function, accepting props,
returning elements. Those elements can be the result of calling other
components!

A component has always the same shape: it accepts some properties, or props, and
returns an `Element`. The props can be of any nature: from a simple, basic
`String`, to a complex record, anything is possible.

```gleam
pub type CounterProps {
  CounterProps(
    count: Int,
    set_count: fn(fn(Int) -> Int) -> Nil,
  )
}

pub fn counter() {
  use props: CounterProps <- redraw.component_("Counter")
  html.button(
    [events.on_click(fn(_) { props.set_count(fn(count) { count + 1 }) })],
    [html.text("count is " <> int.to_string(props.count))],
  )
}
```

but also like this:

```gleam
pub type CounterProps = #(Int, fn(fn(Int) -> Int) -> Nil)

pub fn counter() {
  use #(count, set_count): CounterProps <- redraw.component_("Counter")
  html.button(
    [events.on_click(fn(_) { set_count(fn(count) { count + 1 }) })],
    [html.text("count is " <> int.to_string(count))],
  )
}
```

or even props-less components:

```gleam
pub fn counter() {
  use Nil <- redraw.component_("Counter")
  let #(count, set_count) = redraw.use_state(0)
  html.button(
    [events.on_click(fn(_) { set_count(fn(count) { count + 1 }) })],
    [html.text("count is " <> int.to_string(count))],
  )
}
```

React accepts mainly one shape of props: a JavaScript object. Don't worry about
it though, Redraw takes care of the hard translation work for you. When you send
some Gleam props to a Redraw component, Redraw will convert the props in a
suitable React format, and will convert them once again when going back in the
Gleam world. Everything is done in a transparent way, and DevTools friendly: you
can even see what is sent to React components directly in your browser!

## Some reminders on hooks

Hooks are super-powerful, but they can be dangerous to use. You should never use
hooks outside of custom hooks (functions named `use_[something]`) or in
components! It means you should never use something like `use_effect` or
`use_state` outside of the body of `component_`. If you break that rule, while
it could seem to work, it could at any time break the runtime, and explode. So
keep that rule anytime: no hooks outside of custom hooks or component body.

## Type-checking of hooks

You may notice that hooks often use a dependencies array, to determine if they
have to rerun or not. This is fully supported by Redraw, and leverages Gleam's
abilities! Always pass a tuple of dependencies to hooks. No type-checking is
done at this stage, and probably none will be implemented later, exactly like
it's done with React currently. Be careful to provide the correct dependencies.

```gleam
import gleam/io
import redraw
import redraw/attribute
import redraw/html

fn gleam_is_awesome() {
  use <- redraw.component__("GleamIsAwesome")
  redraw.use_effect(fn() {
    io.println("Hello from component!")
  }, #()) // Passing an empty tuple here is like passing [] in JavaScript.
  html.div([attribute.class("oh-yeah")], [
    html.text("Yeah, for sure")
  ])
}
```

## Using external components

React is greatly used everywhere. It means a lot of components are already
usable out-of-the-box. To do this, you'll have to write some FFI code. The FFI
code is written in usual JavaScript code, using JSX.

> More to come later…

## Is Redraw production-ready?

Of course! Redraw is more than production-ready, it is already used in
production! While Redraw started as a side-project by a single developer, it is
now developed with the help of Steerlab, and is heavily used throughout the
company for various things, from single-page applications to Chrome Extensions.

Redraw supports the latest version of React, and follows its release cycle:
Redraw will never break backwards-compatibility outside of the existing breaking
changes of React. You can expect Redraw to not break your codebase in a
suspicious way, and most new features are pushed as minor changes.

## Future plans — Redraw Linter

At the moment, Redraw leverages the Gleam compiler and does not offer linter
support for critical parts like hooks dependencies. In the future, complementary
linter is planned, and should bridge that gap between Gleam and React. While the
Gleam compiler provides all useful information about Gleam code, the Redraw
linter will focus on specific Redraw requirements.

## Future plans — Fast Refresh support

> More to come later…

## Future plans — React Native support

React is an isolated package, and renderers can be various. Redraw has
successfully been used with Raycast. You can also easily add a `redraw_native`
package, and provide an interface for native components. Everything can be done
quickly and easily, because the entire package is written with as few JavaScript
code as possible. Everything should work almost out-of-the-box, because React is
already working there. You should take inspiration from how `redraw/html` works,
as it will work in the exact same way. It's only a matter of providing the
correct `Element` to `jsx`.

## Why `redraw.component_` instead of `redraw.component`?

> More to come later…

## Contributing

Enjoying Redraw? Contributions are welcome! Feel free to open a PR, or open an
issue!
