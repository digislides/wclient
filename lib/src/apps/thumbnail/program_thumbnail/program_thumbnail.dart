import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/src/apps/thumbnail/frame/frame_thumbnail.dart';

@Component(
  selector: 'program-thumbnail',
  styleUrls: ['program_thumbnail.css'],
  templateUrl: 'program_thumbnail.html',
  directives: [
    NgFor,
    NgIf,
    FrameThumbnailComponent,
  ],
)
class ProgramThumbnailComponent {
  @Input()
  ProgramDesign program;
}
