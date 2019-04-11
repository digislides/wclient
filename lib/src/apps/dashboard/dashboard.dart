import 'package:angular/angular.dart';

import 'widget/program/program_list.dart';
import 'widget/channel/channel_list.dart';
import '../media/media/media.dart';
import 'widget/monitor/monitor_list.dart';

@Component(
  selector: 'dashboard-app',
  styleUrls: ['dashboard.css'],
  templateUrl: 'dashboard.html',
  directives: [
    NgIf,
    ProgramListComponent,
    ChannelListComponent,
    MediaListComponent,
    MonitorListComponent,
  ],
)
class DashboardApp {
  int page = 0;
}
