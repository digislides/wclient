import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/properties/items/pos/pos.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/size/size.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/image/image.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';

@Component(
    selector: 'video-properties',
    styleUrls: ['video_properties.css'],
    templateUrl: 'video_properties.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      SelectBoxBinder,
      PosPropComponent,
      SizePropComponent,
      ImagePropComponent,
      ColorPropComponent,
    ],
    exports: [
      VideoFit,
    ])
class VideoPropertiesComponent {
  @Input()
  Page page;

  @Input()
  VideoItem video;

  VideoPropertiesComponent();
}
