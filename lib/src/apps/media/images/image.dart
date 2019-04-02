import 'dart:math';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

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
class ImageListComponent implements OnInit {
  bool showCreate = false;

  List<MediaImage> images = [];

  void ngOnInit() async {
    await update();
  }

  void update() async {
    images = await mediaImageApi.getAll("");
  }
}
