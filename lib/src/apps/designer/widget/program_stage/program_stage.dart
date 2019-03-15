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

  ProgramStageComponent();

  int holderWidth = 100;

  int holderHeight = 100;

  final selected = <String, Frame>{};

  void onItemClick(MouseEvent event, Frame item) {
    if (event.shiftKey) {
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

    _onSelect.add(selected.values);
  }

  void stageClick(MouseEvent event) {
    final tar = event.target as Element;
    if (tar.classes.contains('viewport') ||
        tar.classes.contains('canvas') ||
        tar.classes.contains('container')) {
      selected.clear();
      _updateSelectedRect();
    }
  }

  final _onSelect = StreamController<Iterable<Frame>>();

  @Output()
  Stream<Iterable<Frame>> get onSelect => _onSelect.stream;

  void setSelection(Frame item) {
    if (!program.design.frames.contains(item)) return;

    selected.clear();
    selected[item.id] = item;
    _updateSelectedRect();
  }

  void onKeyPress(KeyboardEvent event) {
    if (event.keyCode == KeyCode.DELETE) {
      program.design.frames.removeWhere((i) => selected.containsKey(i.id));
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
}
