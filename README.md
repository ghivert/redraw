# Redraw

React bindings for Gleam. Because a lot of frameworks and products are using
React in a day-to-day way, Redraw fills the gap by providing nice, simple API to
work on a React codebase, Gleam-enhanced!

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
yarn add vite-gleam

# If you want to build the project on Vercel or Netlify.
yarn add @chouqueth/gleam

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
