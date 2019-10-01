import 'dart:math';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
  selector: 'pos-prop',
  styleUrls: ['pos.css'],
  templateUrl: 'pos.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
  ],
)
class PosPropComponent {
  @Input()
  Sizable container;

  @Input()
  CanvasItem item;

  void changed(String x, String y) {
    item.pos = Point(int.tryParse(x) ?? 0, int.tryParse(y) ?? 0);
  }

  bool showActions = false;

  void position(String where) {
    switch (where) {
      case 'pos-lefttop':
        item.pos = Point(0, 0);
        break;
      case 'pos-centertop':
        item.pos = Point(((container.width / 2) - (item.width ~/ 2)).toInt(), 0);
        break;
      case 'pos-righttop':
        item.pos = Point(container.width - item.width, 0);
        break;
      case 'pos-leftmid':
        item.pos = Point(0, ((container.height / 2) - (item.height ~/ 2)).toInt());
        break;
      case 'pos-centermid':
        item.pos = Point(((container.width / 2) - (item.width ~/ 2)).toInt(),
            ((container.height / 2) - (item.height ~/ 2)).toInt());
        break;
      case 'pos-rightmid':
        item.pos = Point(container.width - item.width,
            ((container.height / 2) - (item.height ~/ 2)).toInt());
        break;
      case 'pos-leftbottom':
        item.pos = Point(0, container.height - item.height);
        break;
      case 'pos-centerbottom':
        item.pos = Point(((container.width / 2) - (item.width ~/ 2)).toInt(),
            container.height - item.height);
        break;
      case 'pos-rightbottom':
        item.pos = Point(container.width - item.width, container.height - item.height);
        break;
    }
  }
}
