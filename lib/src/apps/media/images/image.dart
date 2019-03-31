import 'dart:math';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/common.dart';

import 'upload/upload.dart';

@Component(
  selector: 'image-list',
  styleUrls: ['image.css'],
  templateUrl: 'image.html',
  directives: [
    NgFor,
    NgIf,
    ImageUploadComponent,
  ],
  exports: [
  ],
)
class ImageListComponent {
  bool showCreate = false;
}
