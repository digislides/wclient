import 'package:angular/angular.dart';

import 'package:common/models.dart';

@Component(
  selector: 'page-properties',
  styleUrls: ['page_properties.css'],
  templateUrl: 'page_properties.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class PageComponent {
  Page page;

  PageComponent();
}
