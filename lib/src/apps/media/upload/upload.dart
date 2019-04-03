import 'dart:html';
import 'package:path/path.dart' as path;

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'media-upload',
  styleUrls: ['upload.css'],
  templateUrl: 'upload.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
  ],
  exports: [],
)
class MediaUploadComponent {
  @ViewChild("file")
  FileUploadInputElement fileInput;

  final tags = <String>[];

  final uploads = <Upload>[];

  void onFilePick(List<File> files) {
    for (File f in files) {
      final up = Upload(
          path.basenameWithoutExtension(f.name), path.extension(f.name), f);
      final fr = FileReader();
      fr.onLoad.listen((_) {
        up.url = fr.result;
      });
      fr.readAsDataUrl(f);
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

  void upload() async {
    for (Upload upload in uploads) {
      final fr = FileReader();
      fr.readAsArrayBuffer(upload.file);
      await fr.onLoad.first;
      final name = upload.name + upload.extension;
      await mediaImageApi.create(MediaCreator(name: name, tags: tags),
          MultipartFile(fr.result, filename: name));
    }
  }
}

class Upload {
  String name;

  String extension;

  Blob file;

  String url;

  Upload(this.name, this.extension, this.file);
}
