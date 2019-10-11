import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/src/apps/designer/widget/stage/items/text_item/text_item.dart';
import 'package:wclient/src/apps/designer/widget/stage/items/image_item/image_item.dart';
import 'package:wclient/src/apps/designer/widget/stage/items/video_item/video_item.dart';
import 'package:wclient/src/apps/designer/widget/stage/items/clock_item/clock_item.dart';
import 'package:wclient/src/apps/designer/widget/stage/items/weather_item/weather_item.dart';

@Component(
  selector: 'page-thumbnail',
  styleUrls: ['page_thumbnail.css'],
  templateUrl: 'page_thumbnail.html',
  directives: [
    NgFor,
    NgIf,
    TextItemComponent,
    ImageItemComponent,
    VideoItemComponent,
    ClockItemComponent,
    WeatherItemComponent,
  ],
  exports: [
    PageItemType,
  ],
)
class PageThumbnailComponent {
  Page _page;

  @Input()
  set page(Page value) {
    _page = value;
    _resize();
  }

  Page get page => _page;

  int _width;

  @Input()
  set width(int value) {
    _width = value;
    _resize();
  }

  int get width => _width;

  int _height;

  @Input()
  set height(int value) {
    _height = value;
    _resize();
  }

  int get height => _height;

  double scale;

  @HostBinding('style.width.px')
  int scaledWidth = 0;

  @HostBinding('style.height.px')
  int scaledHeight = 0;

  String transform;

  void _resize() {
    if (_page != null && _width != null && _height != null) {
      double scaleX = _width / _page.width;
      double scaleY = _height / _page.height;
      if (scaleX < scaleY) {
        scale = scaleX;
      } else {
        scale = scaleY;
      }
    } else {
      scale = 1;
    }
    if (_page != null) {
      scaledWidth = (scale * _page.width).toInt();
      scaledHeight = (scale * _page.height).toInt();
    } else {
      scaledWidth = 0;
      scaledHeight = 0;
    }

    transform = "scale($scale, $scale)";
  }
}
