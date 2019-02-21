import 'package:angular/angular.dart';

import 'package:common/models.dart';

@Component(
  selector: 'frame-item',
  styleUrls: ['frame_item.css'],
  templateUrl: 'frame_item.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class FrameItemComponent {
  @Input()
  Frame item;

  FrameItemComponent();

  @HostBinding('style.left.px')
  int get left => item.left;

  @HostBinding('style.top.px')
  int get top => item.top;

  @HostBinding('style.width.px')
  int get width => item.width;

  @HostBinding('style.height.px')
  int get height => item.height;

  @HostBinding('style.background-color')
  String get color => item.color;
}
