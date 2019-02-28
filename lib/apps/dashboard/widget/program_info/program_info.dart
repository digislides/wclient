import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/utils/api/api.dart';

@Component(
  selector: 'program-info',
  styleUrls: ['program_info.css'],
  templateUrl: 'program_info.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    SelectBoxBinder,
  ],
)
class ProgramInfoComponent {
  @Input()
  Program program;

  final _onCloseController = StreamController<bool>();

  Stream<bool> _onClose;

  @Output()
  Stream<bool> get onClose => _onClose;

  ProgramInfoComponent() {
    _onClose = _onCloseController.stream.asBroadcastStream();
  }

  void close() {
    _onCloseController.add(false);
  }

  void design() {
    window.open("/designer/index.html?id=${program.id}", "_blank");
  }

  Future<void> delete() async {
    await programApi.delete(program.id);
    _onCloseController.add(true);
  }
}
