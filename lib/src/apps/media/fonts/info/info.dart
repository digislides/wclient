import 'dart:html';
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import '../edit/edit.dart';

@Component(
  selector: 'font-info',
  styleUrls: ['info.css'],
  templateUrl: 'info.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    FontEditComponent,
  ],
  exports: [],
)
class FontInfoComponent {
  @Input()
  MediaFont font;

  bool editing = false;

  final _closeCont = StreamController();

  Stream _onClose;

  @Output()
  Stream get onClose => _onClose;

  String baseUrl;

  FontInfoComponent() {
    baseUrl = window.location.origin;
    _onClose = _closeCont.stream.asBroadcastStream();
  }

  Future<void> delete() async {
    await mediaFontApi.delete(font.id);
    _closeCont.add(null);
  }

  void close() {
    _closeCont.add(null);
  }

  void _update() async {
    font = await mediaFontApi.getById(font.id);
  }

  void closeEditing() async {
    editing = false;
    await _update();
  }

  String get url => "$baseUrl${font.url}";
}
