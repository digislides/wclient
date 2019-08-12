part of 'text.dart';

class _ReadContent {
  int pos;

  String content;

  _ReadContent({this.pos, this.content});

  String get part1 => content.substring(0, pos);

  String get part2 => content.substring(pos);
}

_ReadContent _readContent(DivElement contentDiv, _Cursor cursor) {
  final value = StringBuffer();

  int pos;

  for (int i = 0; i < contentDiv.children.length; i++) {
    final el = contentDiv.children[i];
    pos ??= _readFromDiv(value, el, cursor);
    if (i < contentDiv.children.length - 1) value.writeln();
  }

  // print(value.toString());
  return _ReadContent(content: value.toString(), pos: pos);
}

int _readFromDiv(StringBuffer sb, Element div, _Cursor cursor) {
  int cursorPos;

  if (div.children.isNotEmpty) {
    for (Element el in div.children) {
      if (el is SpanElement) {
        if (el.dataset['path'] == null) {
          for (Node node in el.childNodes) {
            if (node is Text) {
              if(node == cursor.node) {
                cursorPos = sb.length + cursor.pos;
              }
              sb.write(node.text);
            }
          }
        } else {
          final path = (jsonDecode(el.dataset['path']) as List).cast<String>();
          final args =
              (jsonDecode(el.dataset['args']) as Map).cast<String, String>();
          final link = DataLink(path, args);
          sb.write(link.toString());
        }
      }
    }
  } else {
    sb.write(div.text);
  }

  return cursorPos;
}

class _Cursor {
  Node node;
  int pos;

  _Cursor({this.node, this.pos});
}
