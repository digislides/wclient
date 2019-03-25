import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/properties/items/pos/pos.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/size/size.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';

@Component(
    selector: 'text-properties',
    styleUrls: ['text_properties.css'],
    templateUrl: 'text_properties.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      TextAreaBinder,
      SelectBoxBinder,
      PosPropComponent,
      SizePropComponent,
      ColorPropComponent,
    ],
    exports: [
      Align,
      VAlign,
    ])
class TextPropertiesComponent {
  @Input()
  TextItem text = TextItem(
    id: '1',
    name: 'Image1',
    top: 20,
    left: 40,
    width: 200,
    height: 300,
    color: 'blue',
    text: "Some text here!",
  );

  TextPropertiesComponent();
}
