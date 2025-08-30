/// Main error type. Currently only used in conjuction with `Context` related
/// functions.
pub type Error {
  /// Error returned from `create_context_`.
  /// Context with the corresponding `name` already exists.
  ExistingContext(name: String)
  /// Error returned from `get_context`.
  /// Context with the corresponding `name` does not exists.
  UnknownContext(name: String)
  /// Error returned from `capture_owner_stack`.
  /// `capture_owner_stack` can only be used in development, and you're not
  /// in development anymore.
  DevelopmentOnly
  /// Error returned from `capture_owner_stack`.
  /// `capture_owner_stack` can sometimes return `null`, when the stack is
  /// unavailable.
  OwnerStackUnavailable
}
