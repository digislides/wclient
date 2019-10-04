import 'dart:html';

Point<int> getOffsetFrom(Point<int> offset, Element descendant, Element from) {
  for (Element parent = descendant; parent != from; parent = parent.parent) {
    offset += Point<int>(parent.offsetLeft, parent.offsetTop);
  }

  return offset;
}