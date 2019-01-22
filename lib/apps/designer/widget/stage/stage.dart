import 'dart:math';
import 'dart:html';
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'items/text_item/text_item.dart';
import 'items/image_item/image_item.dart';

@Injectable()
class SelectionModifier {}

@Component(
  selector: 'page-stage',
  styleUrls: ['stage.css'],
  templateUrl: 'stage.html',
  directives: [NgFor, NgIf, TextItemComponent, ImageItemComponent],
)
class PageStageComponent {
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

  PageStageComponent();

  int holderWidth = 100;

  int holderHeight = 100;

  bool isText(PageItem item) => item is TextItem;

  bool isImage(PageItem item) => item is ImageItem;

  final selected = <String, PageItem>{};

  void onItemClick(MouseEvent event, PageItem item) {
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
      selected.clear();
      _updateSelectedRect();
    }
  }

  final _onSelect = StreamController<Iterable<PageItem>>();

  @Output()
  Stream<Iterable<PageItem>> get onSelect => _onSelect.stream;

  void setSelection(PageItem item) {
    if (!page.items.contains(item)) return;

    selected.clear();
    selected[item.id] = item;
    _updateSelectedRect();
  }

  void onKeyPress(KeyboardEvent event) {
    if (event.keyCode == KeyCode.DELETE) {
      page.items.removeWhere((i) => selected.containsKey(i.id));
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
      }
    }
  }
}
