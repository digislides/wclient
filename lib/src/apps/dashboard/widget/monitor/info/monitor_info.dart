import 'dart:async';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';
import '../edit/monitor_edit.dart';
import '../comm/monitor_comm.dart';

import 'package:common/models.dart';

import 'package:common/api/api.dart';

@Component(
  selector: 'monitor-info',
  styleUrls: ['monitor_info.css'],
  templateUrl: 'monitor_info.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    MonitorEditComponent,
    MonitorCommComponent,
  ],
  exports: [],
)
class MonitorInfoComponent implements OnInit {
  @Input()
  Monitor monitor;

  final _onCloseController = StreamController<bool>();

  Stream<bool> _onClose;

  @Output()
  Stream<bool> get onClose => _onClose;

  MonitorInfoComponent() {
    _onClose = _onCloseController.stream.asBroadcastStream();
  }

  @override
  Future<void> ngOnInit() async {
    await update();
  }

  Future<void> update() async {
    // TODO show spinner
    monitor = await monitorApi.getById(monitor.id);
    // TODO hide spinner
  }

  void close() {
    _onCloseController.add(false);
  }

  bool editing = false;

  bool showingComm = false;

  Future<void> delete() async {
    await monitorApi.delete(monitor.id);
    _onCloseController.add(true);
  }

  Future<void> closeEditor() async {
    editing = false;
    await update();
  }
}
