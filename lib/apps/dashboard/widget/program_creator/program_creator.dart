import 'dart:async';
import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/utils/api/api.dart';

@Component(
  selector: 'program-creator',
  styleUrls: ['program_creator.css'],
  templateUrl: 'program_creator.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    SelectBoxBinder,
  ],
)
class ProgramCreatorComponent {
  final model = ProgramCreator();

  StreamController<String> _OnCloseController = StreamController<String>();

  Stream<String> _onClose;

  @Output()
  Stream<String> get onClose => _onClose;

  ProgramCreatorComponent() {
    _onClose = _OnCloseController.stream.asBroadcastStream();
  }

  Future<void> create() async {
    Program newProgram = await programApi.create(model);
    _OnCloseController.add(newProgram.id);
  }

  void reset() {
    model.reset();
  }

  void close() {
    _OnCloseController.add(null);
  }
}
