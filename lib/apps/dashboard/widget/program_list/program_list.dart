import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/utils/directives/input_binder.dart';

class Paginated<M> {
  int page;

  int numPerPage;

  int totalPages;

  List<M> items;

  Paginated({
    this.page,
    this.numPerPage,
    this.totalPages,
    this.items,
  });
}

class ProgramListService {
  Future<Paginated<Program>> getPrograms(
      String search, int numPerPage, int page) async {
    // TODO
  }
}

@Component(
  selector: 'program-list',
  styleUrls: ['program_list.css'],
  templateUrl: 'program_list.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
  ],
)
class ProgramListComponent {
  /// List of programs
  Paginated programs = Paginated(
    page: 0,
    numPerPage: 6,
    items: [
      Program(name: 'Program1'),
      Program(name: 'Program2'),
      Program(name: 'Program3'),
      Program(name: 'Program4'),
      Program(name: 'Program5'),
      Program(name: 'Program6'),
    ],
    totalPages: 6,
  );

  /// List of recent programs
  List<Program> recent = [
    Program(name: 'Program1'),
    Program(name: 'Program2'),
    Program(name: 'Program3'),
  ];

  ProgramListComponent();
}
