import 'dart:html';
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'video-edit',
  styleUrls: ['edit.css'],
  templateUrl: 'edit.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
  ],
  exports: [],
)
class VideoEditComponent {
  MediaVideo _video;

  @Input()
  set video(MediaVideo value) {
    _video = value;
    if (_video == null) {
      model = MediaCreator(name: "", tags: []);
    } else {
      model = MediaCreator(name: _video.name, tags: _video.tags.toList());
    }
  }

  MediaVideo get video => _video;

  MediaCreator model = MediaCreator(name: "", tags: []);

  bool editing = false;

  final _closeCont = StreamController();

  Stream _onClose;

  @Output()
  Stream get onClose => _onClose;

  VideoEditComponent() {
    _onClose = _closeCont.stream.asBroadcastStream();
  }

  void addTag(InputElement el) {
    final name = el.value;
    if (name.isEmpty || name.contains(RegExp(r"[^a-zA-Z0-9_\-]"))) return;
    model.tags.add(name);
    el.value = "";
  }

  Future<void> save() async {
    await mediaVideoApi.save(video.id, model);
  }

  Future<void> delete() async {
    await mediaVideoApi.delete(video.id);
    _closeCont.add(null);
  }

  void close() {
    _closeCont.add(null);
  }
}
