import 'dart:html';
import 'package:path/path.dart' as path;

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'image-edit',
  styleUrls: ['edit.css'],
  templateUrl: 'edit.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
  ],
  exports: [],
)
class ImageEditComponent {
  MediaImage _image;

  @Input()
  set image(MediaImage value) {
    _image = value;
    if (_image == null) {
      model = MediaCreator(name: "", tags: []);
    } else {
      model = MediaCreator(name: _image.name, tags: _image.tags.toList());
    }
  }

  MediaImage get image => _image;

  MediaCreator model = MediaCreator(name: "", tags: []);

  bool editing = false;

  void addTag(InputElement el) {
    final name = el.value;
    if (name.isEmpty || name.contains(RegExp(r"[^a-zA-Z0-9_\-]"))) return;
    model.tags.add(name);
    el.value = "";
  }

  Future<void> save() async {
    await mediaImageApi.save(image.id, model);
  }

  void close() {
    // TODO
  }
}
