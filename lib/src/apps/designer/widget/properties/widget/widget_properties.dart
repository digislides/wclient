import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/properties/items/pos/pos.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/size/size.dart';

@Component(
    selector: 'widget-properties',
    styleUrls: ['widget_properties.css'],
    templateUrl: 'widget_properties.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      TextAreaBinder,
      SelectBoxBinder,
      PosPropComponent,
      SizePropComponent,
    ],
    exports: [
      Fit,
    ])
class WidgetPropertiesComponent {
  @Input()
  WidgetItem item = WidgetItem(
    id: '1',
    name: 'Widget',
    top: 20,
    left: 40,
    width: 200,
    height: 300,
  );

  WidgetPropertiesComponent();
}
