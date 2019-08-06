import 'dart:html';
import 'dart:async';
import 'package:path/path.dart' as path;

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'media-upload-progress',
  styleUrls: ['progress.css'],
  templateUrl: 'progress.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
  ],
  exports: [],
)
class MediaUploadProgressComponent {
  List<Upload> _uploads;

  List<Upload> get uploads => _uploads;

  @Input()
  set uploads(List<Upload> value) {
    _uploads = value;
    upload();
  }

  bool finished = false;

  int failed = 0;

  final _closeCont = StreamController();

  Stream _onClose;

  @Output()
  Stream get onClose => _onClose;

  MediaUploadProgressComponent() {
    _onClose = _closeCont.stream.asBroadcastStream();
  }

  void upload() async {
    for (Upload upload in _uploads) {
      final fr = FileReader();
      fr.readAsArrayBuffer(upload.file);
      await fr.onLoad.first;
      final name = upload.name + upload.extension;
      try {
        if (upload.type == MediaType.image) {
          upload.media = await mediaImageApi.create(
              MediaCreator(name: name, tags: upload.tags),
              MultipartFile(fr.result, filename: name));
        } else if (upload.type == MediaType.video) {
          upload.media = await mediaVideoApi.create(
              MediaCreator(name: name, tags: upload.tags),
              MultipartFile(fr.result, filename: name));
        } else if (upload.type == MediaType.audio) {
          upload.media = await mediaAudioApi.create(
              MediaCreator(name: name, tags: upload.tags),
              MultipartFile(fr.result, filename: name));
        } else if (upload.type == MediaType.font) {
          upload.media = await mediaFontApi.create(
              MediaCreator(name: name, tags: upload.tags),
              MultipartFile(fr.result, filename: name));
        }
        upload.finished = true;
      } catch (e) {
        failed++;
        upload.failed = true;
      }
    }

    finished = true;
  }

  void uploadMore() {
    _closeCont.add(null);
  }

  void close() {
    window.close();
  }
}

class Upload {
  String name;

  String extension;

  File file;

  // Blob file;

  MediaType type;

  List<String> tags;

  bool failed = false;

  bool finished = false;

  Media media;

  Upload(this.name, this.extension, this.file, this.type, this.tags);
}

enum MediaType {
  image,
  video,
  audio,
  font,
}

MediaType typeToMediaType(String type) {
  switch (type) {
    case "image/png":
    case "image/jpeg":
      return MediaType.image;
    case "video/mp4":
      return MediaType.video;
    case "font/ttf":
    case "":
      return MediaType.font;
    default:
      return null;
  }
}
