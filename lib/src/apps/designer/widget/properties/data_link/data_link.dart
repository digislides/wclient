import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';
import 'package:common/data/data_repo.dart';

@Component(
    selector: 'data-link-picker',
    styleUrls: ['data_link.css'],
    templateUrl: 'data_link.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      SelectBoxBinder,
    ],
    exports: [
      Fit,
    ])
class DataLinkPickerComponent implements AfterViewInit {
  @Input()
  DataRepository repo;

  @override
  void ngAfterViewInit() {
    print(repo.definitions);
  }
}
