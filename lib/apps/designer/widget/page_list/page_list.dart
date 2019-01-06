import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'page-list',
  styleUrls: ['page_list.css'],
  templateUrl: 'page_list.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class PageListComponent {
  PageListComponent();
}
