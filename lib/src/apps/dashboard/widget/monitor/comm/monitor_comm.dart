import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';
import '../edit/monitor_edit.dart';

import 'package:common/models.dart';

import 'package:common/api/api.dart';

@Component(
  selector: 'monitor-comm',
  styleUrls: ['monitor_comm.css'],
  templateUrl: 'monitor_comm.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    MonitorEditComponent,
  ],
  exports: [],
)
class MonitorCommComponent implements OnInit, OnDestroy {
  @Input()
  Monitor monitor;

  final _onCloseController = StreamController<bool>();

  Stream<bool> _onClose;

  @Output()
  Stream<bool> get onClose => _onClose;

  MonitorCommComponent() {
    _onClose = _onCloseController.stream.asBroadcastStream();
  }

  @override
  Future<void> ngOnInit() async {
    // TODO
  }

  Future<void> ngOnDestroy() async {
    // TODO
  }

  void close() {
    _onCloseController.add(false);
  }

  bool showingScreenshot = false;

  Future<void> closeEditor() async {
    showingScreenshot = false;
  }
}
