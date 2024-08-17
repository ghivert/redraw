pub type Error {
  ExistingContext(name: String)
  UnknownContext(name: String)
}
