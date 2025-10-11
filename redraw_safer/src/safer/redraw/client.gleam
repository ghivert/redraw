import redraw/dom/client
import safer/redraw.{type Component, type Element}

pub fn render(
  root: client.Root,
  creator: Component(a),
  return: fn(fn(a) -> Element) -> Element,
) -> Nil {
  let render = redraw.open(creator)
  client.render(root, return(render))
}
