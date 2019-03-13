import 'package:angular/angular.dart';

import '../program_stage/program_stage.dart';
import '../properties/program/program_properties.dart';
import '../properties/frame/frame_properties.dart';

import 'package:common/models.dart';

@Component(
  selector: 'program-designer',
  styleUrls: ['program_designer.css'],
  templateUrl: 'program_designer.html',
  directives: [
    NgIf,
    ProgramStageComponent,
    ProgramPropertiesComponent,
    FramePropertiesComponent,
  ],
  exports: [PageItemType],
)
class ProgramDesignerComponent {
  @Input()
  Program program;

  @ViewChild(ProgramStageComponent)
  ProgramStageComponent stage;

  ProgramDesignerComponent();

  Iterable<Frame> selected = [];

  Frame get firstSelected => selected.first;

  void selectionChanged(Iterable<Frame> items) {
    selected = items;
  }

  void onItemAdd(Frame item) {
    stage.setSelection(item);
  }
}
