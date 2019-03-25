import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'size-prop',
  styleUrls: ['size.css'],
  templateUrl: 'size.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
  ],
)
class SizePropComponent {
  @Input()
  Point<int> pos = Point<int>(0, 0);

  @Output()
  Stream<Point<int>> get onChange => _onChange;

  final _onChangeCont = StreamController<Point<int>>();

  Stream<Point<int>> _onChange;

  SizePropComponent() {
    _onChange = _onChangeCont.stream.asBroadcastStream();
  }

  void colorChanged(String value) {
    // TODO
  }
}
