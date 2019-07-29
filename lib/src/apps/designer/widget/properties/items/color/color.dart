import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_color_picker/angular_color_picker.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

@Component(
  selector: 'color-prop',
  styleUrls: ['color.css'],
  templateUrl: 'color.html',
  directives: [
    NgIf,
    TextBinder,
    SelectBoxBinder,
    AwesomeColorPicker,
  ],
)
class ColorPropComponent {
  @Input()
  String label = 'Color';

  @Input()
  String color = 'rgba(0, 0, 0, 0.0)';

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

  bool paletteOpen = false;
}
