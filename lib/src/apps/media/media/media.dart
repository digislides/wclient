import 'dart:math';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import '../images/image.dart';
import '../videos/video.dart';
import '../fonts/font.dart';

@Component(
  selector: 'media-list',
  styleUrls: ['media.css'],
  templateUrl: 'media.html',
  directives: [
    NgFor,
    NgIf,
    ImageListComponent,
    VideoListComponent,
    FontListComponent,
  ],
  exports: [
  ],
)
class MediaListComponent {
  int selected = 0;

  void launchUploader() {
    window.open("/media/upload/index.html", "_blank");
  }
}
