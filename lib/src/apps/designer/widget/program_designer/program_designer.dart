import 'dart:async';

import 'package:angular/angular.dart';

import '../frame_list/frame_list.dart';
import '../program_stage/program_stage.dart';
import '../properties/program/program_properties.dart';
import '../properties/frame/frame_properties.dart';

import 'package:common/models.dart';

@Component(
  selector: 'program-design',
  styleUrls: ['program_designer.css'],
  templateUrl: 'program_designer.html',
  directives: [
    NgIf,
    FrameListComponent,
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

  ProgramDesignerComponent() {
    _onFrameEdit = _frameEditCont.stream.asBroadcastStream();
  }

  Map<String, Frame> selected = {};

  Frame get firstSelected {
    if(selected.isEmpty) return null;
    return selected.values.first;
  }

  void selectionChanged(Map<String, Frame> items) {
    selected = items;
  }

  void onItemAdd(FrameItemSelectionEvent e) {
    stage.setSelection(e);
  }

  void selectFrame(FrameItemSelectionEvent e) {
    stage.setSelection(e);
  }

  final _frameEditCont = StreamController<Frame>();

  Stream<Frame> _onFrameEdit;

  @Output()
  Stream<Frame> get onFrameEdit => _onFrameEdit;

  void editFrame(Frame frame) {
    _frameEditCont.add(frame);
  }
}
