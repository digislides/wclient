import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'page-list-item',
  styleUrls: ['item.css'],
  templateUrl: 'item.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class PageListItemComponent {
  PageListItemComponent();
}
