import 'dart:async';
import 'dart:html';

import 'dart:convert';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';
import '../edit/monitor_edit.dart';

import 'package:common/models.dart';


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

  String screenshotUrl;

  Future<void> screenshot() async {
    try {
      screenshotUrl = await conn.screenshot();
    } on String catch (e) {
      print("Error: $e");
    }
  }

  void reboot() {
    conn.reboot();
  }

  StreamSubscription<ExecPart> execSub;

  String stdout = "";

  String stderr = "";

  int exitCode;

  void execute(String value) async {
    stdout = "";
    stderr = "";
    exitCode = null;
    final stream = await conn.exec(value);
    // TODO stop subscription
    execSub = stream.listen((final p) {
      if (p is ExecStdout) {
        stdout += p.data;
      } else if (p is ExecStderr) {
        stderr += p.data;
      } else if (p is ExecStatus) {
        exitCode = p.code;
      }
    }, onError: (e) {
      if (e is String) {
        print("Error: $e");
      }
    });
  }
}

class Connection {
  final WebSocket ws;

  Connection(this.ws);

  int _i = 0;

  Completer<String> _screenshots;

  StreamController<ExecPart> _exces;

  Future<void> _init() async {
    ws.onMessage.listen((e) {
      if (e.data is! String) return;
      final Map map = jsonDecode(e.data);
      final id = map["id"];

      if (_i != id) return;

      print(e.data);

      if (map.containsKey("failed")) {
        if (_screenshots != null) {
          _screenshots.completeError(map["failed"]);
          return;
        }

        if (_exces != null) {
          _exces.addError(map["failed"]);
          return;
        }
      }

      if (map["repcmd"] == "screenshot") {
        final url = 'data:image/bmp;base64,' +
            base64.encode((map["file"] as Iterable<dynamic>).cast<int>());
        if (_screenshots != null) {
          _screenshots.complete(url);
          _screenshots = null;
        }
        return;
      } else if (map["repcmd"] == "exec") {
        if (map.containsKey("stdout")) {
          _exces.add(ExecStdout(map["stdout"]));
        } else if (map.containsKey("stderr")) {
          _exces.add(ExecStderr(map["stderr"]));
        } else if (map.containsKey("exitCode")) {
          _exces.add(ExecStatus(map["exitCode"]));
        }
      }
    });
  }

  Future<String> screenshot() async {
    int id = ++_i;
    _exces = null;
    _screenshots = Completer<String>();
    ws.send(jsonEncode({"id": id, "cmd": "screenshot"}));
    return _screenshots.future;
  }

  void reboot() {
    int id = ++_i;
    _screenshots = null;
    _exces = null;
    ws.send(jsonEncode({"id": id, "cmd": "reboot"}));
  }

  Future<Stream<ExecPart>> exec(String command) async {
    int id = ++_i;
    _screenshots = null;
    _exces = StreamController<ExecPart>();
    ws.send(jsonEncode({"id": id, "cmd": "exec", "command": command}));
    return _exces.stream;
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

abstract class ExecPart {}

class ExecStdout implements ExecPart {
  final String data;

  ExecStdout(this.data);
}

class ExecStderr implements ExecPart {
  final String data;

  ExecStderr(this.data);
}

class ExecStatus implements ExecPart {
  final int code;

  ExecStatus(this.code);
}
