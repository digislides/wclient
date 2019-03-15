import 'dart:async';

import 'package:angular/angular.dart';

import '../frame_list/frame_list.dart';
import '../program_designer/program_designer.dart';

import 'package:common/models.dart';

@Component(
  selector: 'program-editor',
  styleUrls: ['program_editor.css'],
  templateUrl: 'program_editor.html',
  directives: [
    NgIf,
    FrameListComponent,
    ProgramDesignerComponent,
  ],
  exports: [],
)
class ProgramEditorComponent {
  Program _program;

  @Input()
  set program(Program value) {
    _program = value;
    if (_program.design.frames.isEmpty) {
      selectedFrame = null;
    } else {
      selectedFrame = _program.design.frames.first;
    }
  }

  @ViewChild(ProgramDesignerComponent)
  ProgramDesignerComponent designer;

  Program get program => _program;

  Frame selectedFrame;

  void selectFrame(Frame frame) {
    selectedFrame = frame;
  }

  final _frameEditCont = StreamController<Frame>();

  Stream<Frame> _onFrameEdit;

  @Output()
  Stream<Frame> get onFrameEdit => _onFrameEdit;

  ProgramEditorComponent() {
    _onFrameEdit = _frameEditCont.stream.asBroadcastStream();
  }

  void editFrame(Frame frame) {
    _frameEditCont.add(frame);
  }
}
