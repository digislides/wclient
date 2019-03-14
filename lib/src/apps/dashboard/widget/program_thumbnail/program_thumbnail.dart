import 'package:angular/angular.dart';
import 'package:common/models.dart';

@Component(
  selector: 'program-thumbnail',
  styleUrls: ['program_thumbnail.css'],
  templateUrl: 'program_thumbnail.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class ProgramThumbnailComponent {
  ProgramDesign program;
}
