import 'dart:html';
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'font-edit',
  styleUrls: ['edit.css'],
  templateUrl: 'edit.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
  ],
  exports: [],
)
class FontEditComponent {
  MediaFont _font;

  @Input()
  set font(MediaFont value) {
    _font = value;
    if (_font == null) {
      model = MediaCreator(name: "", tags: []);
    } else {
      model = MediaCreator(name: _font.name, tags: _font.tags.toList());
    }
  }

  MediaFont get font => _font;

  MediaCreator model = MediaCreator(name: "", tags: []);

  bool editing = false;

  final _closeCont = StreamController();

  Stream _onClose;

  @Output()
  Stream get onClose => _onClose;

  FontEditComponent() {
    _onClose = _closeCont.stream.asBroadcastStream();
  }

  void addTag(InputElement el) {
    final name = el.value;
    if (name.isEmpty || name.contains(RegExp(r"[^a-zA-Z0-9_\-]"))) return;
    model.tags.add(name);
    el.value = "";
  }

  Future<void> save() async {
    await mediaVideoApi.save(font.id, model);
  }

  Future<void> delete() async {
    await mediaVideoApi.delete(font.id);
    _closeCont.add(null);
  }

  void close() {
    _closeCont.add(null);
  }
}
