import 'dart:html';
import 'dart:async';

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import '../edit/edit.dart';

@Component(
  selector: 'image-info',
  styleUrls: ['info.css'],
  templateUrl: 'info.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    ImageEditComponent,
  ],
  exports: [],
)
class ImageInfoComponent {
  @Input()
  MediaImage image;

  bool editing = false;

  final _closeCont = StreamController();

  Stream _onClose;

  @Output()
  Stream get onClose => _onClose;

  ImageInfoComponent() {
    _onClose = _closeCont.stream.asBroadcastStream();
  }

  Future<void> delete() async {
    await mediaImageApi.delete(image.id);
    _closeCont.add(null);
  }

  void close() {
    _closeCont.add(null);
  }

  void _update() async {
    image = await mediaImageApi.getById(image.id);
  }

  void closeEditing() async {
    editing = false;
    await _update();
  }
}
