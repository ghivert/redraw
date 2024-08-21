/// Main error type. Currently, only used in conjuction with `Context` functions.
pub type Error {
  /// Error thrown in `create_context_`.
  /// Context with the corresponding `name` already exists.
  ExistingContext(name: String)
  /// Error thrown in `get_context`.
  /// Context with the corresponding `name` does not exists.
  UnknownContext(name: String)
}
