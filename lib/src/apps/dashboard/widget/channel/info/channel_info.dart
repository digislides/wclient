import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';
import '../edit/channel_edit.dart';

import 'package:common/models.dart';

import 'package:common/api/api.dart';
import 'package:common/utils/published_at_format.dart';

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
  exports: [
    versionToHuman,
  ],
)
class ChannelInfoComponent implements OnInit {
  @Input()
  Channel channel;

  Program program;

  final _onCloseController = StreamController<bool>();

  Stream<bool> _onClose;

  @Output()
  Stream<bool> get onClose => _onClose;

  ChannelInfoComponent() {
    _onClose = _onCloseController.stream.asBroadcastStream();
  }

  @override
  Future<void> ngOnInit() async {
    await update();
  }

  Future<void> update() async {
    // TODO show spinner
    channel = await channelApi.getById(channel.id);
    if (channel.program != null) {
      program = await programApi.getById(channel.program);
    } else {
      program = null;
    }
    // TODO hide spinner
  }

  void close() {
    _onCloseController.add(false);
  }

  bool editing = false;

  void play() {
    window.open("/player/channel/play/index.html?id=${channel.id}", "_blank");
  }

  void preview() {
    window.open(
        "/player/channel/preview/index.html?id=${channel.id}", "_blank");
  }

  Future<void> delete() async {
    await channelApi.delete(channel.id);
    _onCloseController.add(true);
  }

  Future<void> closeEditor() async {
    editing = false;
    await update();
  }
}
