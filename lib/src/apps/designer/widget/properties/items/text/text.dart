import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:common/data/data_repo.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'text-prop-item',
  styleUrls: ['text.css'],
  templateUrl: 'text.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
  ],
)
class TextPropComponent implements AfterViewInit {
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

    print('----');
    print(_text);
    print(curContent);

    contentDiv.children.clear();

    final parsed = DataText.parse(_text);

    DivElement cur = DivElement();

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
        final div = SpanElement()
          ..text = item.path
          ..title = item.path
          ..classes.add('data-link')
          ..dataset['path'] = jsonEncode(item.segments)
          ..dataset['args'] = jsonEncode(item.args)
          ..contentEditable = 'false'
          ..onKeyDown.listen((e) {
            e.preventDefault();
            e.stopPropagation();
          });
        cur.children.add(div);
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
  }

  @override
  void ngAfterViewInit() {
    _render();
  }
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
