import 'dart:html';

import 'package:angular/angular.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/text/text.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/properties/items/pos/pos.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/size/size.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';

@Component(
    selector: 'scroller-properties',
    styleUrls: ['scroller_properties.css'],
    templateUrl: 'scroller_properties.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      TextAreaBinder,
      NumBinder,
      SelectBoxBinder,
      PosPropComponent,
      SizePropComponent,
      ColorPropComponent,
      TextPropComponent,
    ],
    exports: [
      Align,
      VAlign,
    ])
class ScrollerPropertiesComponent {
  @Input()
  Page page;

  @Input()
  ScrollerItem item = ScrollerItem(
    id: '1',
    name: 'Image1',
    top: 20,
    left: 40,
    width: 200,
    height: 300,
    color: 'blue',
  );

  ScrollerPropertiesComponent();

  void setLine(int i, String v) {
    item.lines[i] = v;
  }

  void addLine(TextAreaElement el) {
    item.lines.add(el.value);
    el.value = '';
  }
}
