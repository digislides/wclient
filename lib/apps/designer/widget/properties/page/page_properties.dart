import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
  selector: 'page-properties',
  styleUrls: ['page_properties.css'],
  templateUrl: 'page_properties.html',
  directives: [
    NgFor,
    NgIf,
    InputBinder,
    SelectBoxBinder,
  ],
  exports: [
    Fit,
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

  String get image => page.image;

  set image(String image) {
    print(image);
    page.image = image;
  }
}
