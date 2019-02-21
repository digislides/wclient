import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
  selector: 'program-properties',
  styleUrls: ['program_properties.css'],
  templateUrl: 'program_properties.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
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
