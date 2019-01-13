import 'dart:math';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'items/text_item/text_item.dart';
import 'items/image_item/image_item.dart';

@Component(
  selector: 'page-stage',
  styleUrls: ['stage.css'],
  templateUrl: 'stage.html',
  directives: [NgFor, NgIf, TextItemComponent, ImageItemComponent],
)
class PageStageComponent {
  Page page =
      Page(name: "Page", width: 200, height: 200, color: 'green', items: [
    TextItem(
        id: '0',
        text: "Hello!",
        left: 10,
        top: 20,
        width: 100,
        height: 50,
        bgColor: 'red',
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

  void _updateSelectedRect() {
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
  }

  void stageClick(MouseEvent event) {
    final tar = event.target as Element;
    if (tar.classes.contains('viewport') || tar.classes.contains('canvas')) {
      selected.clear();
      _updateSelectedRect();
    }
  }
}
