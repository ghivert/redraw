/// A Ref is a mutable data stored in React, persisted across renders.
/// They allow to keep track of a DOM node, a component data, or to store a
/// mutable variable in the component, outside of every component lifecycle. \
/// [Documentation](https://react.dev/learn/referencing-values-with-refs)
pub type Ref(a)

/// Set the current value of a ref, overriding its existing content.
@external(javascript, "./ref.ffi.mjs", "setCurrent")
pub fn assign(of ref: Ref(a), with value: a) -> Nil

/// Get the current value of a ref.
@external(javascript, "./ref.ffi.mjs", "getCurrent")
pub fn current(from ref: Ref(a)) -> a
