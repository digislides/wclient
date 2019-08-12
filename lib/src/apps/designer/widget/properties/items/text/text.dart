import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/data/data_repo.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/data_link_picker/data_link_picker.dart';
import 'package:wclient/src/utils/components/data_link_view.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

part 'read_content.dart';
part 'render.dart';

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
    _render(contentDiv, _text, onEdit: _edit);
  }

  String get text => _text;

  String _text = '';

  @ViewChild('content')
  DivElement contentDiv;

  @override
  void ngAfterViewInit() {
    _render(contentDiv, _text, onEdit: _edit);
  }

  TextPropComponent();

  @Output()
  Stream<String> get change => _changeEmitter.stream;

  final _changeEmitter = StreamController<String>();

  void changed() {
    _changeEmitter.add(_readContent(contentDiv, _Cursor()).content);
  }

  DataLink editingLink;

  void _edit(int i, DataLink link) {
    editingLink = link;
    showDataLinkPicker = true;
    // TODO
  }

  void blurred(FocusEvent event) {
    final sel = window.getSelection();
    final range = sel.getRangeAt(0);
    final node = sel.focusNode as Text;
    print(range.startOffset);
    print(node.text);

    _contentRead = _readContent(contentDiv, _Cursor(node: node, pos: range.startOffset));
  }

  _ReadContent _contentRead;

  void linkData() {
    editingLink = null;
    showDataLinkPicker = true;
  }

  void insertDataLink(String link) {
    if (link != null) {
      if(_contentRead != null) {
        // Place it at where the mouse was
        text = _contentRead.part1 + link + _contentRead.part2;
      } else {
        text = _text + link;
      }
    }
    showDataLinkPicker = false;
    _contentRead = null;
  }

  bool showDataLinkPicker = false;
}

