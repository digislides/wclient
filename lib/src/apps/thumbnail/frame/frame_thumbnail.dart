import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/src/apps/thumbnail/page/page_thumbnail.dart';

@Component(
  selector: 'frame-thumbnail',
  styleUrls: ['frame_thumbnail.css'],
  templateUrl: 'frame_thumbnail.html',
  directives: [
    NgFor,
    NgIf,
    PageThumbnailComponent,
  ],
  exports: [
    PageItemType,
  ],
)
class FrameThumbnailComponent {
  Page page;

  Frame _frame;

  @Input()
  set frame(Frame value) {
    _frame = value;
    if (_frame.pages.isNotEmpty)
      page = _frame.pages.first;
    else
      page = null;
    _resize();
  }

  Frame get frame => _frame;

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
    if (_frame != null && _width != null && _height != null) {
      double scaleX = _width / _frame.width;
      double scaleY = _height / _frame.height;
      if (scaleX < scaleY) {
        scale = scaleX;
      } else {
        scale = scaleY;
      }
    } else {
      scale = 1;
    }
    if (_frame != null) {
      scaledWidth = (scale * _frame.width).toInt();
      scaledHeight = (scale * _frame.height).toInt();
    } else {
      scaledWidth = 0;
      scaledHeight = 0;
    }

    transform = "scale($scale, $scale)";
  }
}
