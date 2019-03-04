import 'dart:async';

import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

@Component(
  selector: 'color-picker',
  styleUrls: ['color_picker.css'],
  templateUrl: 'color_picker.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
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
