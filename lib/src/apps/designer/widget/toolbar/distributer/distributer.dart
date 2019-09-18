import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Component(
  selector: 'distributer-tool',
  styleUrls: ['distributer.css'],
  templateUrl: 'distributer.html',
  directives: [
    NgIf,
  ],
)
class DistributerComponent extends OnDestroy {
  StreamSubscription _docClickSub;

  final _performEmitter = StreamController<String>();

  bool show = false;

  DistributerComponent() {
    _docClickSub = document.onClick.listen((e) {
      show = false;
    });
  }

  @Output()
  Stream<String> get perform => _performEmitter.stream;

  @override
  void ngOnDestroy() {
    _docClickSub.cancel();
  }

  void open(Event e) {
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      show = true;
    });
  }

  void align(Event e, String where) {
    e.stopPropagation();
    _performEmitter.add(where);
  }
}
