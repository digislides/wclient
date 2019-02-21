import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
    selector: 'frame-properties',
    styleUrls: ['frame_properties.css'],
    templateUrl: 'frame_properties.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      TextAreaBinder,
      SelectBoxBinder,
    ],
    exports: [
      Align,
    ])
class FramePropertiesComponent {
  @Input()
  Frame frame;

  FramePropertiesComponent();
}
