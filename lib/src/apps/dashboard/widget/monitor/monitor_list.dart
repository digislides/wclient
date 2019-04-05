import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/api/api.dart';
import 'package:wclient/src/utils/pagination/pagination.dart';

import 'create/monitor_creator.dart';

@Component(
  selector: 'monitor-list',
  styleUrls: ['monitor_list.css'],
  templateUrl: 'monitor_list.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    MonitorCreatorComponent,
  ],
)
class MonitorListComponent {
  List<Monitor> monitors = [];

  bool create = false;
}
