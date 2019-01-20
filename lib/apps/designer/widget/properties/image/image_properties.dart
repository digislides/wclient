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
      TextBinder,
      SelectBoxBinder,
    ],
    exports: [
      Fit,
    ])
class ImagePropertiesComponent {
  @Input()
  ImageItem image = ImageItem(
    id: '1',
    name: 'Image1',
    top: 20,
    left: 40,
    width: 200,
    height: 300,
    color: 'blue',
    // TODO url
    // TODO fit
  );

  ImagePropertiesComponent();
}
