import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:common/api/api.dart';

@Component(
  selector: 'channel-edit',
  styleUrls: ['channel_edit.css'],
  templateUrl: 'channel_edit.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    SelectBoxBinder,
  ],
)
class ChannelEditComponent implements OnInit {
  @ViewChild('nameInp')
  InputElement nameInp;

  @Input()
  Channel channel;

  List<Program> programs = [];

  Program program;

  String _programFilter;

  final _onCloseController = StreamController<bool>();

  Stream<bool> _onClose;

  @Output()
  Stream<bool> get onClose => _onClose;

  ChannelEditComponent() {
    _onClose = _onCloseController.stream.asBroadcastStream();
  }

  String get programFilter => _programFilter;

  set programFilter(String value) {
    _programFilter = value;
    _updateProgramFilter();
  }

  Future<void> _updateProgramFilter() async {
    programs = await programApi.getAll(_programFilter ?? '');
  }

  Future<void> ngOnInit() async {
    try {
      if (channel.program != null) {
        program = await programApi.getById(channel.program);
      }
    } catch (e) {
      // TODO
    }
    await _updateProgramFilter();
  }

  void close() {
    _onCloseController.add(false);
  }

  Future<void> save() async {
    final model = ChannelCreator(name: nameInp.value, program: program?.id);
    channel = await channelApi.save(channel.id, model);
  }

  bool selectingProgram = false;
}
