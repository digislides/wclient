part of 'text.dart';

typedef _EditFunc = void Function(int index, DataLink item);

/*
List<List> splitToLines(String text) {
  final parsed = DataText.parse(text);

  final ret = <List>[[]];

  for (var item in parsed.elements) {
    if(item is String) {
      final lines = LineSplitter.split(item);
      ret.addAll(lines.map((v) => [v]));
    } else if(item is DataLink) {
      ret.last.add(item);
    }
  }

  return ret;
}
 */

const int _LF = 10;
const int _CR = 13;

Iterable<String> split(String lines, [int start = 0, int end]) sync* {
  end = RangeError.checkValidRange(start, end, lines.length);
  var sliceStart = start;
  var char = 0;
  for (var i = start; i < end; i++) {
    var previousChar = char;
    char = lines.codeUnitAt(i);
    if (char != _CR) {
      if (char != _LF) continue;
      if (previousChar == _CR) {
        sliceStart = i + 1;
        continue;
      }
    }
    yield lines.substring(sliceStart, i);
    sliceStart = i + 1;
  }
  yield lines.substring(sliceStart, end);
}

void _render(DivElement contentDiv, String text, {_EditFunc onEdit}) {
  final curContent = _readContent(contentDiv, _Cursor());

  if (text == curContent.content) return;

  contentDiv.children.clear();

  final parsed = DataText.parse(text);

  DivElement cur = DivElement();

  int linkId = 0;

  for (var item in parsed.elements) {
    if (item is String) {
      final lines = split(item).toList();
      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.isNotEmpty) {
          cur.children.add(SpanElement()..text = line);
        }
        contentDiv.children.add(cur);
        if (i < lines.length - 1) {
          if (cur.children.isEmpty) cur.children.add(BRElement());
          cur = DivElement();
        }
      }
    } else if (item is DataLink) {
      final withOutMe = (int i) {
        return () {
          final content = _readContent(contentDiv, _Cursor());
          final parsed = DataText.parse(content.content);

          final sb = StringBuffer();

          int linkId = 0;

          for (final el in parsed.elements) {
            if (el is DataLink) {
              if (linkId != i) {
                sb.write(el.toString());
              }
              linkId++;
            } else {
              sb.write(el);
            }
          }

          text = sb.toString();
        };
      };
      final editMe = (int i) {
        return () {
          onEdit(i, item);
        };
      };

      final dataLinkComp = DataLinkView(item,
          onDelete: withOutMe(linkId), onEdit: editMe(linkId));
      cur.children.add(dataLinkComp.root);

      linkId++;
    }
  }

  if (cur.children.isEmpty) cur.children.add(BRElement());
  contentDiv.children.add(cur);
}
