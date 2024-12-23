/// Main error type. Currently only used in conjuction with `Context` related
/// functions.
pub type Error {
  /// Error returned from `create_context_`.
  /// Context with the corresponding `name` already exists.
  ExistingContext(name: String)
  /// Error returned from `get_context`.
  /// Context with the corresponding `name` does not exists.
  UnknownContext(name: String)
}
