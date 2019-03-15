import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/properties/items/image/image.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';

@Component(
    selector: 'frame-properties',
    styleUrls: ['frame_properties.css'],
    templateUrl: 'frame_properties.html',
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
      Transition,
    ])
class FramePropertiesComponent {
  @Input()
  Frame frame;

  FramePropertiesComponent();
}
