import 'dart:async';
import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:common/api/api.dart';

@Component(
  selector: 'monitor-creator',
  styleUrls: ['monitor_creator.css'],
  templateUrl: 'monitor_creator.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    TextAreaBinder,
    SelectBoxBinder,
  ],
)
class MonitorCreatorComponent {
  final model = MonitorCreator();

  StreamController<String> _OnCloseController = StreamController<String>();

  Stream<String> _onClose;

  @Output()
  Stream<String> get onClose => _onClose;

  MonitorCreatorComponent() {
    _onClose = _OnCloseController.stream.asBroadcastStream();
  }

  Future<void> create() async {
    Monitor newMonitor = await monitorApi.create(model);
    _OnCloseController.add(newMonitor.id);
  }

  void reset() {
    model.reset();
  }

  void close() {
    _OnCloseController.add(null);
  }

  void addRow() {
    model.fields.add(InfoField());
  }
}
