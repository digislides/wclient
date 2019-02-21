import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
    selector: 'clock-properties',
    styleUrls: ['clock_properties.css'],
    templateUrl: 'clock_properties.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      SelectBoxBinder,
    ],
    exports: [
      Fit,
    ])
class ClockPropertiesComponent {
  @Input()
  ClockItem item = ClockItem(
    id: '1',
    name: 'Clock1',
    left: 40,
    top: 20,
    size: 100,
  );

  ClockPropertiesComponent();
}
