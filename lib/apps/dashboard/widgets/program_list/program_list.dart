import 'package:angular/angular.dart';
import 'package:common/models.dart';

@Component(
  selector: 'program-list',
  styleUrls: ['program_list.css'],
  templateUrl: 'program_list.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class ProgramListComponent {
  /// List of programs
  List<Program> programs;

  /// List of recent programs
  List<Program> recent;

  ProgramListComponent();
}
