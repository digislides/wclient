
import 'package:angular/angular.dart';

import 'media/media.dart';

@Component(
  selector: 'media-app',
  styleUrls: ['media.css'],
  templateUrl: 'media.html',
  directives: [
    NgIf,
    MediaListComponent,
  ],
)
class MediaApp {}
