import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/program_stage/program_stage.dart';
import 'package:wclient/src/apps/thumbnail/frame/frame_thumbnail.dart';

@Component(
  selector: 'frame-list',
  styleUrls: ['frame_list.css'],
  templateUrl: 'frame_list.html',
  directives: [
    NgFor,
    NgIf,
    FrameThumbnailComponent,
  ],
)
class FrameListComponent {
  @Input()
  Program program;

  @Input()
  Map<String, Frame> selectedFrames;

  @ViewChild('items')
  DivElement itemsDiv;

  final _frameEditCont = StreamController<Frame>();

  Stream<Frame> _onFrameEdit;

  @Output()
  Stream<Frame> get onFrameEdit => _onFrameEdit;

  FrameListComponent() {
    _onFrameEdit = _frameEditCont.stream.asBroadcastStream();
  }

  int counter = 0;

  void addFrame() {
    program.design.addNewFrame(name: "New frame ${counter++}");
  }

  void editFrame(Frame frame) {
    _frameEditCont.add(frame);
  }

  void deleteFrame(Frame frame) {
    if (selectedFrames.containsKey(frame.id)) {
      // If the frame being removed is currently, select a new frame
      final f = program.design.frames
          .firstWhere((p) => p != frame, orElse: () => null);
      _frameSelCntr.add((FrameItemSelectionEvent(f, false)));
    }
    program.design.removeFrame(frame.id);
  }

  void duplicateFrame(Frame frame) {
    program.design.duplicateFrame(frame.id);
  }

  Frame dragging;

  Frame draggingOn;

  void onDragStart(MouseEvent event, Frame frame) {
    dragging = frame;
    int nextIndex = program.design.frames.indexOf(frame) + 1;
    if (nextIndex < program.design.frames.length) {
      draggingOn = program.design.frames[nextIndex];
    } else {
      draggingOn = null;
    }
  }

  void onDragOverItem(MouseEvent event, Frame frame) {
    if (dragging != null && event.buttons == 1) {
      if (frame != null) {
        if (frame != draggingOn) {
          draggingOn = frame;
        } else {
          draggingOn = frame;
          int nextIndex = program.design.frames.indexOf(frame) + 1;
          if (nextIndex < program.design.frames.length) {
            draggingOn = program.design.frames[nextIndex];
          } else {
            draggingOn = null;
          }
        }
      } else {
        draggingOn = null;
      }
    }
  }

  void onDrop(MouseEvent event) {
    if (dragging != null) {
      if (draggingOn != null) {
        program.design.moveFrameTo(
            dragging.id, program.design.frames.indexOf(draggingOn));
      } else {
        program.design.moveFrameTo(dragging.id, program.design.frames.length);
      }
      dragging = null;
      draggingOn = null;
    }
  }

  @HostListener('mouseleave')
  void onMouseLeave(MouseEvent event) {
    if (dragging != null) {
      dragging = null;
      draggingOn = null;
    }
  }

  void onKeyPress(KeyboardEvent event) {
    if (dragging != null) {
      if (event.keyCode == KeyCode.ESC) {
        dragging = null;
        draggingOn = null;
      }
    }
  }

  void autoScroll(MouseEvent event) {
    if (dragging != null && event.buttons == 1) {
      final target = (event.target as Element);
      int y = target.offsetTop -
          itemsDiv.scrollTop -
          itemsDiv.offsetTop +
          event.offset.y;
      if (y < 50) {
        itemsDiv.scrollTop -= 10;
      } else if (y > (itemsDiv.offsetHeight - 50)) {
        itemsDiv.scrollTop += 10;
      }
    }
  }

  final _frameSelCntr = StreamController<FrameItemSelectionEvent>();

  @Output()
  Stream<FrameItemSelectionEvent> get onFrameSelect => _frameSelCntr.stream;

  void selectFrame(MouseEvent e, Frame frame) {
    _frameSelCntr.add(FrameItemSelectionEvent(frame, e.shiftKey));
  }
}
