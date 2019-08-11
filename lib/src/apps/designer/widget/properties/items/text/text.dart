import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/data/data_repo.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/data_link_picker/data_link_picker.dart';
import 'package:wclient/src/utils/components/data_link_view.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'text-prop-item',
  styleUrls: ['text.css'],
  templateUrl: 'text.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    DataLinkPickerComponent,
  ],
)
class TextPropComponent implements AfterViewInit {
  @Input()
  DataRepository repo;

  @Input()
  set text(String value) {
    _text = value;
    _render();
  }

  String get text => _text;

  String _text = '';

  @ViewChild('content')
  DivElement contentDiv;

  void _render() {
    final curContent = _readContent();

    if (_text == curContent) return;

    // print('----');
    // print(_text);
    // print(curContent);

    contentDiv.children.clear();

    final parsed = DataText.parse(_text);

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
            final content = _readContent();
            final parsed = DataText.parse(content);

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
            _edit(i, item);
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

  TextPropComponent();

  @Output()
  Stream<String> get change => _changeEmitter.stream;

  final _changeEmitter = StreamController<String>();

  void changed() {
    _changeEmitter.add(_readContent());
  }

  String _readContent() {
    final value = StringBuffer();

    for (int i = 0; i < contentDiv.children.length; i++) {
      final el = contentDiv.children[i];
      _readFromDiv(value, el);
      if (i < contentDiv.children.length - 1) value.writeln();
    }

    // print(value.toString());
    return value.toString();
  }

  void _readFromDiv(StringBuffer sb, Element div) {
    if (div.children.isNotEmpty) {
      for (Element el in div.children) {
        if (el is SpanElement) {
          if (el.dataset['path'] == null) {
            sb.write(el.text);
          } else {
            final path =
                (jsonDecode(el.dataset['path']) as List).cast<String>();
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
  }

  DataLink editingLink;

  void _edit(int i, DataLink link) {
    editingLink = link;
    showDataLinkPicker = true;
    // TODO
  }

  void blurred(Event event) {
    TextAreaElement tae = event.target;
    int start = tae.selectionStart;
    int end = tae.selectionEnd;
    _blurredAt =
        BlurredAt(at: DateTime.now(), range: Range(start: start, end: end));
  }

  BlurredAt _blurredAt = BlurredAt(at: DateTime.fromMillisecondsSinceEpoch(0));

  void linkData() {
    if (_blurredAt.isValid) {
      final selection =
          text.substring(_blurredAt.range.start, _blurredAt.range.end);
      print(selection);
    }

    editingLink = null;
    showDataLinkPicker = true;
  }

  @override
  void ngAfterViewInit() {
    _render();
  }

  void insertDataLink(String link) {
    if (link != null) {
      text = _text + link;
      // TODO place it at where the mouse was
    } else {
      // TODO set the mouse pointer back
    }
    showDataLinkPicker = false;
  }

  bool showDataLinkPicker = false;
}

class Range {
  int start;

  int end;

  Range({this.start, this.end});
}

class BlurredAt {
  DateTime at;

  Range range;

  BlurredAt({this.at, this.range});

  bool get isValid {
    return DateTime.now().isBefore(at.add(Duration(seconds: 1)));
  }
}
