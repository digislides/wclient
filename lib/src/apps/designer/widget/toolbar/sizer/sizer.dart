import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Component(
  selector: 'sizer-tool',
  styleUrls: ['sizer.css'],
  templateUrl: 'sizer.html',
  directives: [
    NgIf,
  ],
)
class SizerComponent extends OnDestroy {
  StreamSubscription _docClickSub;

  final _performEmitter = StreamController<String>();

  bool show = false;

  SizerComponent() {
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
