import 'package:angular/angular.dart';

import 'package:common/models.dart';

@Component(
  selector: 'scroller-item',
  styleUrls: ['scroller_item.css'],
  templateUrl: 'scroller_item.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class ScrollerItemComponent {
  @Input()
  ScrollerItem item = ScrollerItem(
      id: '1',
      name: 'Image',
      left: 100,
      top: 50,
      width: 200,
      height: 150,
      color: 'red',
      font: FontProperties(
          size: 25, color: 'blue', align: Align.center, bold: true));

  @HostBinding('style.left.px')
  int get left => item.left;

  @HostBinding('style.top.px')
  int get top => item.top;

  @HostBinding('style.width.px')
  int get width => item.width;

  @HostBinding('style.height.px')
  int get height => item.height;

  @HostBinding('style.background-color')
  String get bgColor => item.color;

  @HostBinding('style.font-size.px')
  int get fontSize => item.font.size;

  @HostBinding('style.color')
  String get color => item.font.color;

  @HostBinding('style.font-weight')
  String get bold => item.font.bold ? 'bold' : 'normal';

  @HostBinding('style.text-decoration')
  String get underline => item.font.underline ? 'underline' : 'none';

  @HostBinding('style.font-style')
  String get italic => item.font.italic ? 'italic' : 'normal';

  @HostBinding('class')
  String get classes => "page-item page-item-scroller";
}
