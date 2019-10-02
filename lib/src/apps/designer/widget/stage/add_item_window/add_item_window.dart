import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
    selector: 'add-item-window',
    styleUrls: ['add_item_window.css'],
    templateUrl: 'add_item_window.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      SelectBoxBinder,
    ],)
class AddItemWindowComponent {

}