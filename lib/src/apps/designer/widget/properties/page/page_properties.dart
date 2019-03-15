import 'dart:async';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/properties/items/image/image.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';

@Component(
  selector: 'page-properties',
  styleUrls: ['page_properties.css'],
  templateUrl: 'page_properties.html',
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
  ],
)
class PagePropertiesComponent {
  @Input()
  Page page = Page(
      id: '1',
      name: 'Page1',
      width: 200,
      height: 300,
      color: 'red',
      duration: 5,
      items: []);

  PagePropertiesComponent();

  void add(String type) {
    switch (type) {
      case 'text':
        final item = TextItem();
        page.addNewItem(item);
        _itemAddCntr.add(item);
        break;
      case 'image':
        final item = ImageItem();
        page.addNewItem(item);
        _itemAddCntr.add(item);
        break;
      case 'video':
        final item = VideoItem();
        page.addNewItem(item);
        _itemAddCntr.add(item);
        break;
      case 'clock':
        final item = ClockItem();
        page.addNewItem(item);
        _itemAddCntr.add(item);
        break;
      case 'weather':
        final item = WeatherItem();
        page.addNewItem(item);
        _itemAddCntr.add(item);
        break;
    }
  }

  final _itemAddCntr = StreamController<PageItem>();

  @Output()
  Stream get onItemAdd => _itemAddCntr.stream;
}
