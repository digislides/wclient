
import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/properties/items/image/image.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';

import '../../page_scheduler/page_scheduler.dart';

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
    PageSchedulerComponent,
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

  bool showSchedule = false;

  PagePropertiesComponent();
}
