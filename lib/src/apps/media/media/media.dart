import 'dart:math';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import '../images/image.dart';

@Component(
  selector: 'media-list',
  styleUrls: ['media.css'],
  templateUrl: 'media.html',
  directives: [
    NgFor,
    NgIf,
    ImageListComponent,
  ],
  exports: [
  ],
)
class MediaListComponent {
  int selected = 0;
}
