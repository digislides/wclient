import 'dart:html';
import 'package:path/path.dart' as path;

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'image-info',
  styleUrls: ['info.css'],
  templateUrl: 'info.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
  ],
  exports: [],
)
class ImageInfoComponent {
  @Input()
  MediaImage image;

  bool editing = false;

  Future<void> delete() async {
    // TODO
  }

  void close() {
    // TODO
  }
}
