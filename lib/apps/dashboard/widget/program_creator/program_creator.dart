import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

import 'package:wclient/utils/api/api.dart';

@Component(
  selector: 'program-creator',
  styleUrls: ['program_creator.css'],
  templateUrl: 'program_creator.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    NumBinder,
    SelectBoxBinder,
  ],
)
class ProgramCreatorComponent {
  final model = ProgramCreator();

  ProgramCreatorComponent();

  Future<void> create() async {
    print(model);
    await programApi.create(model);
    // TODO
  }

  void reset() {
    model.reset();
  }
}
