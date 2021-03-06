import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/image/image.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/timezone/timezone.dart';

import 'package:common/models.dart';

@Component(
    selector: 'clock-properties',
    styleUrls: ['clock_properties.css'],
    templateUrl: 'clock_properties.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      SelectBoxBinder,
      ColorPropComponent,
      ImagePropComponent,
      TimezonePropComponent,
    ],
    exports: [
      Fit,
    ])
class ClockPropertiesComponent {
  @Input()
  Page page;

  @Input()
  ClockItem item = ClockItem(
    id: '1',
    name: 'Clock1',
    left: 40,
    top: 20,
    size: 100,
  );

  ClockPropertiesComponent();
}
