import 'dart:math';
import 'dart:html';
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'items/frame_item.dart';

@Component(
  selector: 'program-stage',
  styleUrls: ['program_stage.css'],
  templateUrl: 'program_stage.html',
  directives: [
    NgFor,
    NgIf,
    FrameItemComponent,
  ],
)
class ProgramStageComponent {
  Program _program;

  @Input()
  set program(Program program) {
    if (_program != program) {
      _program = program;
      selected.clear();
      _updateSelectedRect();
    }
  }

  Program get program => _program;

  @ViewChild("viewport")
  DivElement viewportDiv;

  @ViewChild("canvas")
  DivElement canvasDiv;

  ProgramStageComponent();

  int holderWidth = 100;

  int holderHeight = 100;

  final selected = <String, Frame>{};

  void _select(FrameItemSelectionEvent e) {
    final item = e.item;
    if (e.shift) {
      if (selected.containsKey(item.id)) {
        selected.remove(item.id);
      } else {
        selected[item.id] = item;
      }
    } else {
      selected.clear();
      selected[item.id] = item;
    }

    _updateSelectedRect();
  }

  void onItemClick(MouseEvent event, Frame item) {
    _select(FrameItemSelectionEvent(item, event.shiftKey));
  }

  Rectangle<int> selectedRect;

  final _rectUpdates = <StreamSubscription>[];

  void _updateSelectedRect() {
    for (final sub in _rectUpdates) {
      sub.cancel();
    }
    _rectUpdates.clear();

    selected.values.forEach((i) {
      _rectUpdates.add(i.onRectChange.listen((r) {
        _updateSelectedRect();
      }));
    });

    if (selected.isNotEmpty) {
      final first = selected.values.first;
      int left = first.left;
      int top = first.top;
      int right = first.left + first.width;
      int bottom = first.top + first.height;

      for (Frame item in selected.values) {
        int myRight = item.left + item.width;
        int myBottom = item.top + item.height;

        if (item.left < left) left = item.left;
        if (item.top < top) top = item.top;
        if (myRight > right) right = myRight;
        if (myBottom > bottom) bottom = myBottom;
      }

      selectedRect = Rectangle<int>.fromPoints(
          Point<int>(left, top), Point<int>(right, bottom));
    } else {
      selectedRect = null;
    }

    _onSelect.add(selected);
  }

  void stageClick(MouseEvent event) {
    final tar = event.target as Element;
    if (tar.classes.contains('viewport') ||
        tar.classes.contains('canvas') ||
        tar.classes.contains('container')) {
      if (_moveStart == null &&
          _hResizeStart == null &&
          _vResizeStart == null) {
        selected.clear();
        _updateSelectedRect();
      }

      viewportDiv.classes.remove("moving");
      _moveStart = null;
      _moveStarts = null;
      _hResizeStart = null;
      _hResizeStarts = null;
      _vResizeStart = null;
      _vResizeStarts = null;
    }
  }

  final _onSelect = StreamController<Map<String, Frame>>();

  @Output()
  Stream<Map<String, Frame>> get onSelect => _onSelect.stream;

  void setSelection(FrameItemSelectionEvent e) {
    if (!program.design.frames.contains(e.item)) return;

    _select(e);
  }

  void onKeyPress(KeyboardEvent event) {
    if (event.keyCode == KeyCode.DELETE) {
      selected.values.forEach((i) => program.design.removeFrame(i.id));
      selected.clear();
      _updateSelectedRect();
      return;
    }

    int factor = 5;
    if (event.shiftKey) {
      factor = 10;
    } else if (event.altKey) {
      factor = 1;
    }
    if (!event.ctrlKey) {
      if (event.keyCode == KeyCode.UP) {
        for (Frame item in selected.values) {
          item.top -= factor;
        }
      } else if (event.keyCode == KeyCode.DOWN) {
        for (Frame item in selected.values) {
          item.top += factor;
        }
      } else if (event.keyCode == KeyCode.LEFT) {
        for (Frame item in selected.values) {
          item.left -= factor;
        }
      } else if (event.keyCode == KeyCode.RIGHT) {
        for (Frame item in selected.values) {
          item.left += factor;
        }
      }
    } else {
      if (event.keyCode == KeyCode.UP) {
        for (Frame item in selected.values) {
          item.height -= factor;
        }
      } else if (event.keyCode == KeyCode.DOWN) {
        for (Frame item in selected.values) {
          item.height += factor;
        }
      } else if (event.keyCode == KeyCode.LEFT) {
        for (Frame item in selected.values) {
          item.width -= factor;
        }
      } else if (event.keyCode == KeyCode.RIGHT) {
        for (Frame item in selected.values) {
          item.width += factor;
        }
      }
    }
  }

  Point<int> _moveStart;

  Map<String, Point<int>> _moveStarts;

  void onMoveStart(MouseEvent e) {
    if (e.buttons != 1) return;

    if (selected.isNotEmpty) {
      viewportDiv.classes.add("moving");

      _moveStart = selectedRect.topLeft;
      _moveStarts = {};
      for (Frame item in selected.values) {
        _moveStarts[item.id] = item.pos;
      }
    }
  }

  void onMouseMove(MouseEvent e) {
    if (_moveStart != null) {
      var diff = e.offset - _moveStart - Point<int>(50, 50);
      diff = Point<int>(diff.x.toInt(), diff.y.toInt());
      for (Frame sel in selected.values) {
        sel.pos = _moveStarts[sel.id] + diff;
      }
      _updateSelectedRect();
    }
    if (_hResizeStart != null) {
      num diff =
          ((e.offset.x - 50) - _hResizeStart.left) / (_hResizeStart.width);
      if (!diff.isNegative) {
        for (Frame sel in selected.values) {
          sel.left = _hResizeStart.left +
              ((_hResizeStarts[sel.id].left - _hResizeStart.left) * diff)
                  .toInt();
          sel.width = (_hResizeStarts[sel.id].width * diff).toInt();
        }
      } else {
        diff = diff.abs();
        for (Frame sel in selected.values) {
          sel.left = ((_hResizeStart.left - (_hResizeStart.width * diff)) +
                  ((_hResizeStarts[sel.id].left - _hResizeStart.left) * diff))
              .toInt();
          sel.width = (_hResizeStarts[sel.id].width * diff).toInt();
        }
      }
      _updateSelectedRect();
    }
    if (_vResizeStart != null) {
      num diff =
          ((e.offset.y - 50) - _vResizeStart.top) / (_vResizeStart.height);
      if (!diff.isNegative) {
        for (Frame sel in selected.values) {
          sel.top = _vResizeStart.top +
              ((_vResizeStarts[sel.id].top - _vResizeStart.top) * diff).toInt();
          sel.height = (_vResizeStarts[sel.id].height * diff).toInt();
        }
      } else {
        diff = diff.abs();
        for (Frame sel in selected.values) {
          sel.top = ((_vResizeStart.top - (_vResizeStart.height * diff)) +
                  ((_vResizeStarts[sel.id].top - _vResizeStart.top) * diff))
              .toInt();
          sel.height = (_vResizeStarts[sel.id].height * diff).toInt();
        }
      }
      _updateSelectedRect();
    }
  }

  void onMouseLeave(MouseEvent e) {
    viewportDiv.classes.remove("moving");
    _moveStart = null;
    _moveStarts = null;
    _hResizeStart = null;
    _hResizeStarts = null;
    _vResizeStart = null;
    _vResizeStarts = null;
  }

  Rectangle<int> _hResizeStart;

  Map<String, Rectangle<int>> _hResizeStarts;

  void onHResizeStart(MouseEvent e) {
    if (e.buttons != 1) return;

    if (selected.isNotEmpty) {
      viewportDiv.classes.add("moving");

      _hResizeStart = selectedRect;
      _hResizeStarts = {};
      for (Frame item in selected.values) {
        _hResizeStarts[item.id] = item.rect;
      }
    }
  }

  Rectangle<int> _vResizeStart;

  Map<String, Rectangle<int>> _vResizeStarts;

  void onVResizeStart(MouseEvent e) {
    if (e.buttons != 1) return;

    if (selected.isNotEmpty) {
      viewportDiv.classes.add("moving");

      _vResizeStart = selectedRect;
      _vResizeStarts = {};
      for (Frame item in selected.values) {
        _vResizeStarts[item.id] = item.rect;
      }
    }
  }
}

class FrameItemSelectionEvent {
  final Frame item;

  final bool shift;

  FrameItemSelectionEvent(this.item, this.shift);
}
