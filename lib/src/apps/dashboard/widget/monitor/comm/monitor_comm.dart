import 'dart:async';
import 'dart:html';

import 'dart:convert';

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

  Connection conn;

  final _onCloseController = StreamController<bool>();

  Stream<bool> _onClose;

  @Output()
  Stream<bool> get onClose => _onClose;

  MonitorCommComponent() {
    _onClose = _onCloseController.stream.asBroadcastStream();
  }

  @override
  Future<void> ngOnInit() async {
    conn = await Connection.make(monitor.id);
    await conn.exec("ls");
  }

  Future<void> ngOnDestroy() async {
    conn?.stop();
  }

  void close() {
    _onCloseController.add(false);
  }

  bool showingScreenshot = false;

  Future<void> closeEditor() async {
    showingScreenshot = false;
  }

  bool showExecute = false;
}

class Connection {
  final WebSocket ws;

  Connection(this.ws);

  Future<void> _init() async {
    ws.onMessage.listen((e) {
      print(e.data);
    });
  }

  Future<void> exec(String command) async {
    ws.send(jsonEncode({"cmd": "exec", "command": command}));
  }

  Future<void> stop() async {
    ws.close();
  }

  static Future<Connection> make(String id) async {
    final ws = WebSocket("ws://localhost:10000/api/monitor/$id/rt");

    await ws.onOpen.first;
    print("Opened!");

    final conn = Connection(ws);
    await conn._init();
    return conn;
  }
}
