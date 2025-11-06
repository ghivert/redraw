/// Transtype any data. It should never be used, unless the underlying runtime
/// is able to react to both data types.
///
/// ```gleam
/// let data: Int = 1
/// let data: String = unsafe.coerce(data)
/// // BOOM
/// ```
@external(javascript, "./unsafe.ffi.mjs", "coerce")
pub fn coerce(a: a) -> b
