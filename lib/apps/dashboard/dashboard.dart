import 'package:angular/angular.dart';

import 'widget/program_list/program_list.dart';
import 'widget/program_creator/program_creator.dart';

import 'package:common/models.dart';

@Component(
  selector: 'dashboard-app',
  styleUrls: ['dashboard.css'],
  templateUrl: 'dashboard.html',
  directives: [ProgramListComponent],
)
class DashboardApp {}
