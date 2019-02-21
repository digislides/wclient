import 'dart:html';

import 'package:angular/angular.dart';

import 'package:common/models.dart';

import 'package:wclient/utils/components/clock.dart';

@Component(
  selector: 'clock-item',
  styleUrls: ['clock_item.css'],
  templateUrl: 'clock_item.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class ClockItemComponent {
  @Input()
  ClockItem item = ClockItem(
    id: '1',
    name: 'Clock',
    left: 50,
    top: 50,
    size: 100,
  );

  final _clockComp = ClockComponent();

  ClockItemComponent(HtmlElement root) {
    root.children.add(_clockComp.root);
  }

  @HostBinding('style.left.px')
  int get left => item.left;

  @HostBinding('style.top.px')
  int get top => item.top;

  @HostBinding('style.width.px')
  int get width => item.width;

  @HostBinding('style.height.px')
  int get height => item.height;

  // TODO background color
}
