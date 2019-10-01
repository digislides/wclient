import 'dart:math';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
  selector: 'size-prop',
  styleUrls: ['size.css'],
  templateUrl: 'size.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
  ],
)
class SizePropComponent {
  @Input()
  Sizable container;

  @Input()
  CanvasItem item;

  void changed(String x, String y) {
    item.size = Point(int.tryParse(x) ?? 0, int.tryParse(y) ?? 0);
  }

  bool showActions = false;

  void sizer(String where) {
    switch (where) {
      case 'size-extend-width':
        final newWidth = container.width - item.left;
        if (newWidth > 0) item.width = newWidth;
        break;
      case 'size-extend-height':
        final newHeight = container.height - item.top;
        if (newHeight > 0) item.height = newHeight;
        break;
      case 'size-extend-width-ratio':
        final newWidth = container.width - item.left;

        if (newWidth <= 0) break;
        double ratio = item.height / item.width;
        item.width = newWidth;
        item.height = (ratio * newWidth).toInt();
        break;
      case 'size-extend-height-ratio':
        final newHeight = container.height - item.top;
        if (newHeight <= 0) break;
        double ratio = item.width / item.height;
        item.height = newHeight;
        item.width = (ratio * newHeight).toInt();
        break;
    }
  }
}
