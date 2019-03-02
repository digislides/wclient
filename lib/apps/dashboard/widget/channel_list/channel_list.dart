import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:wclient/apps/dashboard/widget/channel_creator/channel_creator.dart';
import 'package:wclient/apps/dashboard/widget/channel_info/channel_info.dart';

import 'package:wclient/utils/api/api.dart';
import 'package:wclient/utils/pagination/pagination.dart';

@Component(
  selector: 'channel-list',
  styleUrls: ['channel_list.css'],
  templateUrl: 'channel_list.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    ChannelCreatorComponent,
    ChannelInfoComponent,
  ],
)
class ChannelListComponent implements OnInit {
  /// List of programs
  Paginated channels = Paginated(
    page: 0,
    numPerPage: 6,
    items: [],
    totalPages: 6,
  );

  bool creating = false;

  String search = "";

  Channel selected;

  ChannelListComponent();

  void showCreate() {
    creating = true;
  }

  Future<void> refresh() async {
    List<Channel> channels = await channelApi.getAll(search);
    this.channels = Paginated(
      items: channels,
      numPerPage: channels.length,
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

  void select(Channel channel) {
    selected = channel;
  }

  void onInfoClose(bool deleted) {
    selected = null;
    refresh();
    if (deleted) {
      // TODO show message
    }
  }
}
