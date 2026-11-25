/// A data-only module: no component, only a custom type shared with the
/// components. Editing it must keep the values held in states valid.
pub type Filter {
  All
  Active
  Done
}

pub fn name(filter: Filter) -> String {
  case filter {
    All -> "all"
    Active -> "active"
    Done -> "done"
  }
}
