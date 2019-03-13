import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/properties/items/image/image.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';

@Component(
    selector: 'image-properties',
    styleUrls: ['image_properties.css'],
    templateUrl: 'image_properties.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      SelectBoxBinder,
      ImagePropComponent,
      ColorPropComponent,
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
