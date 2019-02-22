import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';
import 'package:wclient/apps/dashboard/widget/channel_edit/channel_edit.dart';

import 'package:common/models.dart';

import 'package:wclient/utils/api/api.dart';

@Component(
  selector: 'channel-info',
  styleUrls: ['channel_info.css'],
  templateUrl: 'channel_info.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    SelectBoxBinder,
    ChannelEditComponent,
  ],
)
class ChannelInfoComponent {
  @Input()
  Channel channel;

  final _onCloseController = StreamController<bool>();

  Stream<bool> _onClose;

  @Output()
  Stream<bool> get onClose => _onClose;

  ChannelInfoComponent() {
    _onClose = _onCloseController.stream.asBroadcastStream();
  }

  void close() {
    _onCloseController.add(false);
  }

  bool editing = false;

  void preview() {
    window.open("/channel/preview/index.html?id=${channel.id}", "blank");
  }

  Future<void> delete() async {
    await channelApi.delete(channel.id);
    _onCloseController.add(true);
  }

  void closeEditor() {
    editing = false;
  }
}
