import 'package:angular/angular.dart';

import 'widget/program_list/program_list.dart';
import 'widget/channel_list/channel_list.dart';
import '../media/media/media.dart';

@Component(
  selector: 'dashboard-app',
  styleUrls: ['dashboard.css'],
  templateUrl: 'dashboard.html',
  directives: [
    NgIf,
    ProgramListComponent,
    ChannelListComponent,
    MediaListComponent,
  ],
)
class DashboardApp {
  int page = 0;
}
