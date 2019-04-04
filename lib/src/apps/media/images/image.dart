import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'info/info.dart';

@Component(
  selector: 'image-list',
  styleUrls: ['image.css'],
  templateUrl: 'image.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    ImageInfoComponent,
  ],
  exports: [
  ],
)
class ImageListComponent implements OnInit {
  List<MediaImage> images = [];

  void ngOnInit() async {
    await update();
  }

  void update() async {
    images = await mediaImageApi.getAll("");
  }

  MediaImage showing;

  void closeShowing() async {
    showing = null;
    await update();
  }

  String search = "";

  List<String> tags = [];

  void addTag(InputElement el) {
    final name = el.value;
    if (name.isEmpty || name.contains(RegExp(r"[^a-zA-Z0-9_\-]"))) return;
    tags.add(name);
    el.value = "";
  }
}
