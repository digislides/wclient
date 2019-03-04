import 'dart:async';

import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

@Component(
  selector: 'image-prop',
  styleUrls: ['image.css'],
  templateUrl: 'image.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
  ],
)
class ImagePropComponent {
  @Input()
  String image = 'none';

  @Input()
  String imageUrl = 'none';

  @Output()
  Stream<String> get onChange => _onChange;

  final _onChangeCont = StreamController<String>();

  Stream<String> _onChange;

  ImagePropComponent() {
    _onChange = _onChangeCont.stream.asBroadcastStream();
  }

  void imageChanged(String value) {
    _onChangeCont.add(value);
  }
}
