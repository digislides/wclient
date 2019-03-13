import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/properties/items/image/image.dart';
import 'package:wclient/src/apps/designer/widget/properties/items/color/color.dart';

@Component(
  selector: 'program-properties',
  styleUrls: ['program_properties.css'],
  templateUrl: 'program_properties.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
    ImagePropComponent,
    ColorPropComponent,
  ],
  exports: [
    Fit,
  ],
)
class ProgramPropertiesComponent {
  @Input()
  Program program;

  ProgramPropertiesComponent();
}
