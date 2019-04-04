import 'dart:html';
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import '../edit/edit.dart';

@Component(
  selector: 'video-info',
  styleUrls: ['info.css'],
  templateUrl: 'info.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    VideoEditComponent,
  ],
  exports: [],
)
class VideoInfoComponent {
  @Input()
  MediaVideo video;

  bool editing = false;

  final _closeCont = StreamController();

  Stream _onClose;

  @Output()
  Stream get onClose => _onClose;

  String baseUrl;

  VideoInfoComponent() {
    baseUrl = window.location.origin;
    _onClose = _closeCont.stream.asBroadcastStream();
  }

  Future<void> delete() async {
    await mediaVideoApi.delete(video.id);
    _closeCont.add(null);
  }

  void close() {
    _closeCont.add(null);
  }

  void _update() async {
    video = await mediaVideoApi.getById(video.id);
  }

  void closeEditing() async {
    editing = false;
    await _update();
  }
}
