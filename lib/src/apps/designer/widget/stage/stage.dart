import 'dart:math';
import 'dart:html';
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:wclient/src/apps/designer/widget/stage/add_item_window/add_item_window.dart';
import 'package:wclient/src/apps/designer/widget/stage/items/scroller_item/scroller_item.dart';
import 'package:wclient/src/apps/designer/widget/stage/items/widget_item/widget_item.dart';
import 'package:wclient/src/utils/directives/input_binder.dart';

import 'items/text_item/text_item.dart';
import 'items/image_item/image_item.dart';
import 'items/video_item/video_item.dart';
import 'items/clock_item/clock_item.dart';
import 'items/weather_item/weather_item.dart';

@Injectable()
class SelectionModifier {}

@Component(
  selector: 'page-stage',
  styleUrls: ['stage.css'],
  templateUrl: 'stage.html',
  directives: [
    NgFor,
    NgIf,
    NumBinder,
    TextItemComponent,
    ImageItemComponent,
    VideoItemComponent,
    ClockItemComponent,
    WeatherItemComponent,
    WidgetItemComponent,
    ScrollerItemComponent,
    AddItemWindowComponent,
  ],
  exports: [
    PageItemType,
  ],
)
class PageStageComponent implements AfterViewInit, OnDestroy {
  Page _page =
      Page(name: "Page", width: 200, height: 200, color: 'green', items: [
    TextItem(
        id: '0',
        text: "Hello!",
        left: 10,
        top: 20,
        width: 100,
        height: 50,
        color: 'red',
        font: FontProperties(size: 25)),
    ImageItem(
        id: '1',
        name: 'Image',
        left: 10,
        top: 50,
        width: 150,
        height: 100,
        url:
            'http://as01.epimg.net/en/imagenes/2018/03/04/football/1520180124_449729_noticia_normal.jpg',
        fit: Fit.cover)
  ]);

  @Input()
  set page(Page page) {
    if (_page != page) {
      _page = page;
      selected.clear();
      _updateSelectedRect();
    }
  }

  Page get page => _page;

  @ViewChild("container")
  DivElement containerDiv;

  @ViewChild("viewport")
  DivElement viewportDiv;

  @ViewChild("canvas")
  DivElement canvasDiv;

  PageStageComponent();

  StreamSubscription _onPasteSub;

  void ngAfterViewInit() {
    _onPasteSub = document.onPaste.listen((e) {
      if (e.target != document.body) return;

      if (e.clipboardData.types.contains('text/plain')) {
        page.addNewItem(TextItem(text: e.clipboardData.getData('text/plain')));
      }
    });
  }

  @override
  void ngOnDestroy() {
    if (_onPasteSub != null) {
      _onPasteSub.cancel();
      _onPasteSub = null;
    }
  }

  int holderWidth = 100;

  int holderHeight = 100;

  final selected = <String, PageItem>{};

  void setSelection(PageItemSelectionEvent e) {
    if (!page.items.contains(e.item)) return;

    _select(e);
  }

  void _select(PageItemSelectionEvent e) {
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

  void onItemClick(MouseEvent event, PageItem item) {
    _select(PageItemSelectionEvent(item, event.shiftKey));
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

      for (PageItem item in selected.values) {
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

  final _onSelect = StreamController<Iterable<PageItem>>();

  @Output()
  Stream<Iterable<PageItem>> get onSelect => _onSelect.stream;

  void onKeyPress(KeyboardEvent event) {
    if (event.keyCode == KeyCode.DELETE) {
      selected.values.forEach((i) => page.removeItem(i.id));
      selected.clear();
      _updateSelectedRect();
      return;
    } else if (event.keyCode == KeyCode.ESC) {
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
        for (PageItem item in selected.values) {
          item.top -= factor;
        }
      } else if (event.keyCode == KeyCode.DOWN) {
        for (PageItem item in selected.values) {
          item.top += factor;
        }
      } else if (event.keyCode == KeyCode.LEFT) {
        for (PageItem item in selected.values) {
          item.left -= factor;
        }
      } else if (event.keyCode == KeyCode.RIGHT) {
        for (PageItem item in selected.values) {
          item.left += factor;
        }
      }
    } else {
      if (event.keyCode == KeyCode.UP) {
        for (PageItem item in selected.values) {
          item.height -= factor;
        }
      } else if (event.keyCode == KeyCode.DOWN) {
        for (PageItem item in selected.values) {
          item.height += factor;
        }
      } else if (event.keyCode == KeyCode.LEFT) {
        for (PageItem item in selected.values) {
          item.width -= factor;
        }
      } else if (event.keyCode == KeyCode.RIGHT) {
        for (PageItem item in selected.values) {
          item.width += factor;
        }
      } else if (event.keyCode == 187) {
        zoomIn();
        event.preventDefault();
      } else if (event.keyCode == 189) {
        zoomOut();
        event.preventDefault();
      } else if (event.keyCode == KeyCode.SPACE) {
        fitToViewport();
        event.preventDefault();
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
      for (PageItem item in selected.values) {
        _moveStarts[item.id] = item.pos;
      }
    }
  }

  void onMouseMove(MouseEvent e) {
    if (_moveStart != null) {
      var diff = e.offset - _moveStart - Point<int>(50, 50);
      diff = Point<int>(diff.x.toInt(), diff.y.toInt());
      for (PageItem sel in selected.values) {
        sel.pos = _moveStarts[sel.id] + diff;
      }
      _updateSelectedRect();
    }
    if (_hResizeStart != null) {
      num diff =
          ((e.offset.x - 50) - _hResizeStart.left) / (_hResizeStart.width);
      if (!diff.isNegative) {
        for (PageItem sel in selected.values) {
          sel.left = _hResizeStart.left +
              ((_hResizeStarts[sel.id].left - _hResizeStart.left) * diff)
                  .toInt();
          sel.width = (_hResizeStarts[sel.id].width * diff).toInt();
        }
      } else {
        diff = diff.abs();
        for (PageItem sel in selected.values) {
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
        for (PageItem sel in selected.values) {
          sel.top = _vResizeStart.top +
              ((_vResizeStarts[sel.id].top - _vResizeStart.top) * diff).toInt();
          sel.height = (_vResizeStarts[sel.id].height * diff).toInt();
        }
      } else {
        diff = diff.abs();
        for (PageItem sel in selected.values) {
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
      for (PageItem item in selected.values) {
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
      for (PageItem item in selected.values) {
        _vResizeStarts[item.id] = item.rect;
      }
    }
  }

  int scale = 100;

  void setScale(int newScale, [Point<int> pivotAt]) {
    final oldScale = scale;
    final oldScrollPos =
        Point<int>(containerDiv.scrollLeft, containerDiv.scrollTop);
    if (pivotAt == null) {
      pivotAt = Point<int>(
          (containerDiv.offsetWidth ~/ 2), (containerDiv.offsetHeight ~/ 2));
    }
    final oldPivot =
        Point<int>(containerDiv.scrollLeft, containerDiv.scrollTop) + pivotAt;

    if (newScale <= 0) {
      newScale = scale;
    }
    scale = newScale;

    final newPivot = Point<int>(((oldPivot.x / oldScale) * scale).toInt(),
        ((oldPivot.y / oldScale) * scale).toInt());

    final newScrollPos =
        Point<int>(newPivot.x - pivotAt.x, newPivot.y - pivotAt.y);

    containerDiv.scrollLeft = newScrollPos.x;
    containerDiv.scrollTop = newScrollPos.y;
  }

  void zoomIn([Point<int> centerAt]) {
    setScale(scale + 25, centerAt);
  }

  void zoomOut([Point<int> centerAt]) {
    setScale(scale - 25, centerAt);
  }

  void fitToViewport() {
    num width = page.width;
    num height = page.height;
    num ratio = page.width / page.height;
    int scale = 100;
    if (page.width > containerDiv.clientWidth) {
      width = containerDiv.clientWidth;
      height = width / ratio;
      scale = (containerDiv.clientWidth / page.width * 100).toInt();
    }
    if (height > containerDiv.clientHeight) {
      height = containerDiv.clientHeight;
      width = height * ratio;
      scale = (containerDiv.clientHeight / page.height * 100).toInt();
    }
    setScale(scale);
  }

  void restoreScale() => scale = 100;

  String get scaleCss => 'scale(${scale / 100})';

  void onWheel(WheelEvent event) {
    if (event.ctrlKey) {
      var point = (event.client - containerDiv.getBoundingClientRect().topLeft);
      point = Point<int>(point.x.toInt(), point.y.toInt());
      if (event.deltaY > 0) {
        zoomOut(point);
      } else if (event.deltaY < 0) {
        zoomIn(point);
      }
      event.preventDefault();
    }
  }

  void sizer(String where) {
    switch (where) {
      case 'extend_width':
        if (selected.isNotEmpty) {
          for (PageItem item in selected.values) {
            final newWidth = page.width - item.left;
            if (newWidth > 0) item.width = newWidth;
          }
        }
        break;
      case 'extend_height':
        if (selected.isNotEmpty) {
          for (PageItem item in selected.values) {
            final newHeight = page.height - item.top;
            if (newHeight > 0) item.height = newHeight;
          }
        }
        break;
      case 'fullsize':
        if (selected.isNotEmpty) {
          for (PageItem item in selected.values) {
            item.width = page.width;
            item.height = page.height;
          }
        }
        break;
    }
  }

  bool showAdd = true;
}

class PageItemSelectionEvent {
  final PageItem item;

  final bool shift;

  PageItemSelectionEvent(this.item, this.shift);
}

int modn(int q, int d) {
  int mod = q % d;
  int gap = q ~/ d;
  gap += mod ~/ d;
  return gap;
}

Point<int> getOffsetFrom(Element descendant, Element from) {
  var offset = Point<int>(0, 0);
  for (Element parent = descendant; parent != from; parent = parent.parent) {
    offset += Point<int>(parent.offsetLeft, parent.offsetTop);
  }
  return offset;
}
