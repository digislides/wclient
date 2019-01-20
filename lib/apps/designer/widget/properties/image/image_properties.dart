import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
  selector: 'image-properties',
  styleUrls: ['image_properties.css'],
  templateUrl: 'image_properties.html',
  directives: [
    NgFor,
    NgIf,
    InputBinder,
  ],
)
class ImagePropertiesComponent {
  @Input()
  ImageItem image = ImageItem(
    id: '1',
    name: 'Image1',
    top: 20,
    left: 40,
    width: 200,
    height: 300,
    bgColor: 'blue',
    // TODO url
    // TODO fit
  );

  ImagePropertiesComponent();

  String get left => image.left.toString();

  set left(String val) => image.left = int.tryParse(val) ?? 0;

  String get top => image.top.toString();

  set top(String val) => image.top = int.tryParse(val) ?? 0;

  String get width => image.width.toString();

  set width(String val) => image.width = int.tryParse(val) ?? 0;

  String get height => image.height.toString();

  set height(String val) => image.height = int.tryParse(val) ?? 0;
}
