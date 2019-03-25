import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'pos-prop',
  styleUrls: ['pos.css'],
  templateUrl: 'pos.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
  ],
)
class PosPropComponent {
  @Input()
  Point<int> pos = Point<int>(0, 0);

  @Output()
  Stream<Point<int>> get onChange => _onChange;

  final _onChangeCont = StreamController<Point<int>>();

  Stream<Point<int>> _onChange;

  PosPropComponent() {
    _onChange = _onChangeCont.stream.asBroadcastStream();
  }

  void changed(String x, String y) {
    _onChangeCont.add(Point(int.tryParse(x) ?? 0, int.tryParse(y) ?? 0));
  }
}
