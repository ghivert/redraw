# Redraw

React opinionated bindings for Gleam. Because a lot of frameworks and products
are using React in a day-to-day way, Redraw fills the gap by providing nice,
simple API to work on a React codebase, Gleam-enhanced!

> [!TIP]
>
> Have you tried [Lustre](https://lustre.build)? Lustre requires almost no
> knowledge of JavaScript, no complicated runtimes to get like Node.js, few
> knowledge of HTML/CSS and other web technologies, less code interfaces to
> write than Redraw, and is supported by the entire Gleam community! Before
> launching into Redraw, you should take a look at Lustre, it provides a
> user-friendly, awesome experience right out-of-the-box for every gleamlins!
> Plus, Lustre is homomorphic, i.e. it can be used as well on client and on
> server with the same codebase! When using Redraw, you assume to have knowledge
> about frontend development.

## Overview

Redraw is a package to help you use React in a frontend-only Gleam project. By
leveraging on the entire JS ecosystem, Redraw help you interop with existing
current React codebases, or allow you to build your custom codebase and
cherry-picking the existing components you know and love! Redraw tries to keep
everything at the lowest level possible, turning all the React niceties into
Gleam niceties. Wherever possible, Redraw tries to stick with Lustre API, to
help you create a codebase mixing the two frameworks. For instance, you could
build libraries targeting both Lustre and Redraw, and using the same design
system for all your products!

## Prerequisites

Redraw assumes that you're a fluent frontend developer and already understand
how React works. If you don't, it's best to first learn React and the frontend
ecosystem, and come back here later. Meanwhile, you could also take a look at
[Lustre](https://lustre.build) to solve your problems.

Redraw assumes you have [`node.js`](https://nodejs.org/en) as well as a decent
package manager, i.e. `npm`, `yarn` or `pnpm`. Redraw also assumes you're using
[`Vite`](https://vitejs.dev/) as a tooling, to build your application.

## Getting started

Create the project, and add everything needed to make it work. Choose your
prefered bundler to start. Create a Vite application, and choose to use
JavaScript and React. Vite should bundle everything for you directly.

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

From the follow-on, `yarn` will be used to illustrate the commands, it's up to
you to see how to use your desired package manager. Then, it's time to setup the
project correctly.

```sh
cd [project-name]
yarn install

# Install the Vite Gleam plugin.
yarn add -D vite-gleam

# If you want to build the project on Vercel or Netlify.
yarn add -D @chouqueth/gleam

# Remove the files needed for `gleam new` to work.
rm README.md
mv .gitignore .gitignore.old

# Setup the project.
gleam new .
gleam add redraw redraw_dom
```

Now that everyting is setup, you have to add the `vite-gleam` plugin in
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

Writing Redraw components is the same as writing React component, with one small
difference: wrap the component in `use <- redraw.component()`!

```gleam
import redraw
import redraw/attribute
import redraw/html

pub fn gleam_is_awesome() {
  use <- redraw.component__("GleamIsAwesome")
  html.div([attribute.class("oh-yeah")], [
    html.text("Yeah, for sure")
  ])
}
```

While this could feels strange at first, you'll get used to it quickly. To call
the component, it's needed to call the function first, _before definining a new
component_.

```gleam
import redraw
import redraw/attribute
import redraw/html
import redraw_dom/client

pub fn main() {
  let root = root()
  client.create_root("root")
  |> client.render(redraw.strict_mode([root()]))
}

fn root() {
  // Call `gleam_is_awesome` here, before component creation, otherwise a new
  // component will be created at each refresh.
  let gleam_is_awesome = gleam_is_awesome()
  use <- redraw.component__("Root")
  html.div([], [
    gleam_is_awesome()
  ])
}

fn gleam_is_awesome() {
  use <- redraw.component__("GleamIsAwesome")
  html.div([attribute.class("oh-yeah")], [
    html.text("Yeah, for sure")
  ])
}
```

And you know everything to create Redraw components!

## What is the kind of components?

Components can have different kinds, accepting props, children, ref, or other
things. To provide a simpler, usable API in Gleam, props components in Gleam can
be List, Tuple or CustomTypes. It means you can totally define your component
like this:

```gleam
pub type CounterProps {
  CounterProps(
    count: Int,
    set_count: fn(fn(Int) -> Int) -> Nil,
  )
}

pub fn counter() {
  use props: CounterProps <- react.component_("Counter")
  html.button(
    [h.on_click(fn(_) { props.set_count(fn(count) { count + 1 }) })],
    [html.text("count is " <> int.to_string(props.count))],
  )
}
```

but also like this:

```gleam
pub type CounterProps = #(Int, fn(fn(Int) -> Int) -> Nil)

pub fn counter() {
  use #(count, set_count): CounterProps <- react.component_("Counter")
  html.button(
    [h.on_click(fn(_) { set_count(fn(count) { count + 1 }) })],
    [html.text("count is " <> int.to_string(count))],
  )
}
```

Don't worry about the translation of data from and to React, Redraw handles the
hard task for you!

### `component`-family functions

To define components, you should use `component`, `component_` or `component__`.
The difference between the three is the signature of the resulting component.
`component` accepts props and children, `component_` accepts only props, and
`component__` do not accept anything. See it as a way to create an empty
component, used with contexts or internal state for instance.

### `forward_ref`-family functions

Defining components sometimes involves to forward a ref to internal component.
React uses the mechanism of `forwardRef` to push a ref, from the parent to a
nested child. Redraw fully implements forwarded ref components! Use
`forward_ref` or `forward_ref_` to create a component with props, ref and
children, or only with props and children!

## Some reminders on hooks

Never use hooks outside of custom hooks (functions named `use_[something]`) or
in components! It means you should never use something like `use_effect` or
`use_state` outside of the body of `component`-related functions. If you break
that rule, while it could seem to work, it's actually breaking the runtime, and
it can explode at any time. So keep that rule anytime: no hooks outside of
custom hooks or component body.

## Type-checking of hooks

You could see that hooks often use dependencies array, to determine if they have
to rerun or not. This is totally supported by Redraw, and leverages on Gleam
abilities! Always pass a tuple of dependencies to hooks. No type-checking are
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
usable out-of-the-box. Happily, Redraw provides a way to interop directly with
them! Use `to_component` and `to_component_` to integrate a foreign function
directly. Define the correct props, and your work is done! Don't worry about
snake_case and camelCase of props name, Redraw take care of the translation for
you. Everytime you put an `Option(a)`, Redraw will also translate it to
`a | null`, because React use the convention to pass `null` everywhere instead
of optionals.

```gleam
import gleam/option.{type Option}
import redraw
import redraw/html

// This type will be converted to correct JS props.
pub type ExternalComponentProps {
  ExternalComponentProps(
    first_field: Bool,             // firstField: bool
    second_field: Bool,            // secondField: bool
    optional_field: Option(String) // optionalField: string | null
  )
}

@external(javascript, "external_module", "ExternalComponent")
fn external_component_ffi(props: a) -> redraw.Component

fn external_component() -> fn(ExternalComponentProps) -> redraw.Component {
  redraw.to_component_("ExternalComponent", external_component_ffi)
}

pub fn my_other_component() {
  let external_component = external_component()
  use <- redraw.component__("OtherComponent")
  html.div([], [
    external_component(
      ExternalComponentProps(
        first_field: True,
        second_field: False,
        optional_field: option.None,
      )
    )
  ])
}
```

## Miscellaneous

Some questions, answers, and various informations.

### What is the state of support for React Native, or any other React flavor?

React is an isolated packages, and renderers can be various. Redraw has
successfully be used with Raycast. You can also easily add a `redraw_native`
package, and provide an interface for native components. Everything can be done
quickly and easily, because the entire package is written with as few JS as
possible. Everything should work almost out-of-the box, because React is already
working there. You should take inspiration at how is working `redraw/html`, and
it could work in the exact same way. It's only a matter of providing the correct
Component to `jsx`.

### Contributing

Do you love the package? You can contribute! Feel free to open a PR, or open an
issue!

### Why wrapping every components in `use props <- component(name)`?

If you're used to React, you know a component is no more than a function,
returning a `ReactNode`. Something like this:

```javascript
function GleamIsAwesome(props) {
  return <div className="oh-yeah">Yeah, for sure</div>
}
```

Actually, because of JSX, React is a bit lying to all of us, and compiles it to:

```javascript
import { jsx } from "react/runtime-jsx"

function GleamIsAwesome(props) {
  return jsx("div", { className: "oh-yeah", children: "Yeah, for sure" })
}
```

React injects a call to `jsx` before every JSX render. This allows for the
runtime to determine if the function should be called once again with the new
provided props. It's also true for functions.

```javascript
// That code
function ILoveBeam(props) {
  return <div>BEAM 💜</div>
}

function GleamIsAwesome(props) {
  return (
    <div className="oh-yeah">
      <ILoveBeam />
      Yeah, for sure
    </div>
  )
}

// Turns into
import { jsx, jsxs } from "react/runtime-jsx"

function ILoveBeam(props) {
  return jsx("div", { children: "BEAM 💜" })
}

function GleamIsAwesome(props) {
  return jsxs("div", {
    className: "oh-yeah",
    children: [jsx(ILoveBeam, {}), "Yeah, for sure"],
  })
}
```

Here, we got a problem: we cannot inject the `jsx` call before `ILoveBeam` in
Gleam. What we could do is write a function that generate the `jsx` call with an
other function with `use`, but anonymous functions cannot be used with React:
React is doing referential equality for Functional Components. Every component
should be defined once and for all.

To inject the `jsx` call properly, it would requires an additional
compilation-step. Because we cannot do this, we pass by a generator function.
That's what `use props <- component(name)` is doing. To get the correct result,
we go to a _Component creator_, a function that create a component once and for
all from a `render` function. Everytime we create a component, we use a render
function and turns it into a proper component to be used with React.
