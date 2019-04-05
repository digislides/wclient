import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:common/api/api.dart';

@Component(
  selector: 'monitor-edit',
  styleUrls: ['monitor_edit.css'],
  templateUrl: 'monitor_edit.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    SelectBoxBinder,
  ],
)
class MonitorEditComponent {
  @ViewChild('nameInp')
  InputElement nameInp;

  @Input()
  Monitor monitor;

  final _onCloseController = StreamController<bool>();

  Stream<bool> _onClose;

  @Output()
  Stream<bool> get onClose => _onClose;

  MonitorEditComponent() {
    _onClose = _onCloseController.stream.asBroadcastStream();
  }

  void close() {
    _onCloseController.add(false);
  }

  Future<void> save() async {
    final model = MonitorCreator()..name = nameInp.value;
    // TODO fields
    monitor = await monitorApi.save(monitor.id, model);
  }
}
