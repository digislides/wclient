import 'dart:async';
import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:common/api/api.dart';

@Component(
  selector: 'channel-creator',
  styleUrls: ['channel_creator.css'],
  templateUrl: 'channel_creator.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    SelectBoxBinder,
  ],
)
class ChannelCreatorComponent {
  final model = ChannelCreator();

  StreamController<String> _OnCloseController = StreamController<String>();

  Stream<String> _onClose;

  @Output()
  Stream<String> get onClose => _onClose;

  ChannelCreatorComponent() {
    _onClose = _OnCloseController.stream.asBroadcastStream();
  }

  Future<void> create() async {
    Channel newChannel = await channelApi.create(model);
    _OnCloseController.add(newChannel.id);
  }

  void reset() {
    model.reset();
  }

  void close() {
    _OnCloseController.add(null);
  }
}
