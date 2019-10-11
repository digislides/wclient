import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/api/api.dart';
import 'package:wclient/src/utils/pagination/pagination.dart';

import 'create/monitor_creator.dart';
import 'info/monitor_info.dart';

@Component(
  selector: 'monitor-list',
  styleUrls: ['monitor_list.css'],
  templateUrl: 'monitor_list.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    MonitorCreatorComponent,
    MonitorInfoComponent,
  ],
)
class MonitorListComponent implements OnInit {
  Paginated monitors = Paginated<Monitor>(
    page: 0,
    numPerPage: 6,
    items: [],
    totalPages: 6,
  );

  bool create = false;

  String search;

  Monitor showing;

  Future<void> refresh() async {
    List<Monitor> mons = await monitorApi.getAll(search);
    this.monitors = Paginated(
      items: mons,
      numPerPage: mons.length,
      page: 0,
      totalPages: 1,
    );
  }

  void ngOnInit() async {
    await refresh();
  }

  void onInfoClose(bool deleted) async {
    showing = null;
    await refresh();
    if (deleted) {
      // TODO show message
    }
  }

  void creatorClose(String id) async {
    create = false;
    if (id != null) {
      await refresh();
    }
  }
}
