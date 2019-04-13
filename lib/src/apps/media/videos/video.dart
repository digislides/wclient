import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'info/info.dart';

@Component(
  selector: 'video-list',
  styleUrls: ['video.css'],
  templateUrl: 'video.html',
  directives: [
    NgFor,
    NgIf,
    VideoInfoComponent,
  ],
  exports: [],
)
class VideoListComponent implements OnInit {
  List<MediaVideo> videos = [];

  void ngOnInit() async {
    await update();
  }

  void update() async {
    videos = await mediaVideoApi.getAll("");
  }

  MediaVideo showing;

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
