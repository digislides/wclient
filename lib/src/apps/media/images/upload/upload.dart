import 'dart:html';
import 'package:path/path.dart' as path;

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/common.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'image-upload',
  styleUrls: ['upload.css'],
  templateUrl: 'upload.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
  ],
  exports: [],
)
class ImageUploadComponent {
  final uploads = <Upload>[];

  void onFilePick(List<File> files) {
    for (File f in files) {
      uploads.add(Upload(path.basenameWithoutExtension(f.name),
          path.extension(f.name), f.slice()));
    }
  }
}

class Upload {
  String name;

  String extension;

  Blob file;

  Upload(this.name, this.extension, this.file);
}
