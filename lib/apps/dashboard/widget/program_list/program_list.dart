import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:wclient/apps/dashboard/widget/program_creator/program_creator.dart';
import 'package:wclient/apps/dashboard/widget/program_info/program_info.dart';

import 'package:wclient/utils/api/api.dart';
import 'package:wclient/utils/pagination/pagination.dart';

@Component(
  selector: 'program-list',
  styleUrls: ['program_list.css'],
  templateUrl: 'program_list.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    ProgramCreatorComponent,
    ProgramInfoComponent,
  ],
)
class ProgramListComponent implements OnInit {
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

  bool creating = false;

  String search = "";

  Program selected;

  ProgramListComponent();

  void showCreate() {
    creating = true;
  }

  Future<void> refresh() async {
    List<Program> programs = await programApi.getAll(search);
    this.programs = Paginated(
      items: programs,
      numPerPage: programs.length,
      page: 0,
      totalPages: 1,
    );
  }

  void ngOnInit() {
    refresh();
  }

  void closeCreator(String id) {
    creating = false;
    refresh();
  }

  void select(Program program) {
    selected = program;
  }

  void onInfoClose(bool deleted) {
    selected = null;
    refresh();
    if (deleted) {
      // TODO show message
    }
  }
}
