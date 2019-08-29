part of 'text.dart';

class _ReadContent {
  int pos;

  String content;

  _ReadContent({this.pos, this.content});

  String get part1 => content.substring(0, pos);

  String get part2 => pos != null ? content.substring(pos) : "";
}

_ReadContent _readContent(DivElement contentDiv, _Cursor cursor) {
  final value = StringBuffer();

  int pos;

  for (int i = 0; i < contentDiv.childNodes.length; i++) {
    final el = contentDiv.childNodes[i];
    pos ??= _readFromDiv(value, el, cursor);
    if (i < contentDiv.childNodes.length - 1) value.writeln();
  }

  // print(value.toString());
  return _ReadContent(content: value.toString(), pos: pos);
}

int _readFromDiv(StringBuffer sb, Node div, _Cursor cursor) {
  int cursorPos;

  if (div == cursor.node) {
    cursorPos = sb.length + cursor.pos;
  }

  if (div is Element) {
    if (div.childNodes.isNotEmpty) {
      for (Node el in div.childNodes) {
        if (el is SpanElement) {
          if (el.dataset['path'] == null) {
            for (Node node in el.childNodes) {
              if (node is Text) {
                if (node == cursor.node) {
                  cursorPos = sb.length + cursor.pos;
                }
                sb.write(node.text);
              }
            }
          } else {
            final path =
                (jsonDecode(el.dataset['path']) as List).cast<String>();
            final args =
                (jsonDecode(el.dataset['args']) as Map).cast<String, String>();
            final link = DataLink(path, args);
            sb.write(link.toString());
          }
        } else if (el is Text) {
          if (el == cursor.node) {
            cursorPos = sb.length + cursor.pos;
          }
          sb.write(el.text);
        }
      }
    } else {
      sb.write(div.text);
    }
  } else if (div is Text) {
    sb.write(div.text);
  }

  return cursorPos;
}

class _Cursor {
  Node node;
  int pos;

  _Cursor({this.node, this.pos});
}
