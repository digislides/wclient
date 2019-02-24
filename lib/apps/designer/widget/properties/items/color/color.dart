import 'dart:async';

import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
  selector: 'color-prop',
  styleUrls: ['color.css'],
  templateUrl: 'color.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
  ],
  exports: [
    Fit,
  ],
)
class ColorPropComponent {
  @Input()
  String color = 'transparent';

  @Output()
  Stream<String> get onChange => _onChange;

  final _onChangeCont = StreamController<String>();

  Stream<String> _onChange;

  ColorPropComponent() {
    _onChange = _onChangeCont.stream.asBroadcastStream();
  }

  void colorChanged(String value) {
    _onChangeCont.add(value);
  }
}
