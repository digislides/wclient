part of 'text.dart';

typedef _EditFunc = void Function(int index, DataLink item);

void _render(DivElement contentDiv, String text, {_EditFunc onEdit}) {
  final curContent = _readContent(contentDiv, _Cursor());

  if (text == curContent.content) return;

  contentDiv.children.clear();

  final parsed = DataText.parse(text);

  DivElement cur = DivElement();

  int linkId = 0;

  for (var item in parsed.elements) {
    if (item is String) {
      final lines = LineSplitter.split(item).toList();
      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.isNotEmpty) {
          cur.children.add(SpanElement()..text = line);
        } else {
          cur.children.add(BRElement());
        }
        contentDiv.children.add(cur);
        if (i < lines.length - 1) cur = DivElement();
      }
    } else if (item is DataLink) {
      /*
        final div = SpanElement()
          ..onClick.listen((_) {
            showDataLinkPicker = true;
          });
          */
      final withOutMe = (int i) {
        return () {
          final content = _readContent(contentDiv, _Cursor());
          final parsed = DataText.parse(content.content);

          final sb = StringBuffer();

          int linkId = 0;

          for(final el in parsed.elements) {
            if(el is DataLink) {
              if(linkId != i) {
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

  contentDiv.children.add(cur);
}