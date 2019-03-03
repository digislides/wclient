import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/apps/designer/widget/properties/items/image/image.dart';
import 'package:wclient/apps/designer/widget/properties/items/color/color.dart';

@Component(
    selector: 'video-properties',
    styleUrls: ['video_properties.css'],
    templateUrl: 'video_properties.html',
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
class VideoPropertiesComponent {
  @Input()
  VideoItem video;

  VideoPropertiesComponent();
}
