import 'dart:html';
import 'package:path/path.dart' as path;

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'progress/progress.dart';

@Component(
  selector: 'media-upload',
  styleUrls: ['upload.css'],
  templateUrl: 'upload.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    MediaUploadProgressComponent,
  ],
  exports: [],
)
class MediaUploadComponent {
  @ViewChild("file")
  FileUploadInputElement fileInput;

  final tags = <String>[];

  final uploads = <Upload>[];

  bool uploading = false;

  void onFilePick(List<File> files) {
    for (File f in files) {
      final type = typeToMediaType(f.type);
      if (type == null) continue;
      final up = Upload(path.basenameWithoutExtension(f.name),
          path.extension(f.name), f, type, tags);
      uploads.add(up);
    }
    fileInput.value = "";
  }

  void addTag(InputElement el) {
    final name = el.value;
    if (name.isEmpty || name.contains(RegExp(r"[^a-zA-Z0-9_\-]"))) return;
    tags.add(name);
    el.value = "";
  }

  void upload() {
    if (uploads.isEmpty) return;
    uploading = true;
  }

  void onProgressClose() {
    uploads.clear();
    tags.clear();
    uploading = false;
  }
}
