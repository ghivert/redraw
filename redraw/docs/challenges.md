### Why wrap every component in `use props <- component(name)`?

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

Here, we have a problem: we cannot inject the `jsx` call before `ILoveBeam` in
Gleam. What we could do is write a function that generates the `jsx` call with
another function with `use`, but anonymous functions cannot be used with React:
React is doing referential equality for Functional Components. Every component
should be defined once and for all.

To inject the `jsx` call properly, it would require an additional compilation
step. Because we cannot do this, we use a generator function. That's what
`use props <- component(name)` is doing. To get the correct result, we use a
_Component creator_, a function that creates a component once and for all from a
`render` function. Every time we create a component, we use a render function
and turn it into a proper component to be used with React.
