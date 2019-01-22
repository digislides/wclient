import 'package:angular/angular.dart';

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
