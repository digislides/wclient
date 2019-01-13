import 'package:angular/angular.dart';

import 'package:common/models.dart';

@Component(
  selector: 'text-item',
  styleUrls: ['text_item.css'],
  templateUrl: 'text_item.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class TextItemComponent {
  @Input()
  TextItem item = TextItem(
      id: '1',
      name: 'Image',
      left: 100,
      top: 50,
      width: 200,
      height: 150,
      bgColor: 'red',
      text: 'Hello!',
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
  String get bgColor => item.bgColor;

  @HostBinding('style.font-size')
  int get fontSize => item.font.size;

  @HostBinding('style.text-align')
  String get textAlign => item.font.align.toString();

  @HostBinding('style.color')
  String get color => item.font.color;

  @HostBinding('style.font-weight')
  String get bold => item.font.bold.toString();
}
