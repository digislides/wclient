import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/image/image.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/timezone/timezone.dart';

import 'package:common/models.dart';

@Component(
    selector: 'weather-properties',
    styleUrls: ['weather_properties.css'],
    templateUrl: 'weather_properties.html',
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
      WeatherTheme,
      WeatherIconType,
    ])
class WeatherPropertiesComponent {
  @Input()
  Page page;

  @Input()
  WeatherItem item;

  WeatherPropertiesComponent();
}
