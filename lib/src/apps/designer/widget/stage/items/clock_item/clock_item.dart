import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:common/models.dart';

import 'package:wclient/src/utils/components/clock.dart';

@Component(
  selector: 'clock-item',
  styleUrls: ['clock_item.css'],
  templateUrl: 'clock_item.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class ClockItemComponent implements OnDestroy {
  ClockItem _item = ClockItem(
    id: '1',
    name: 'Clock',
    left: 50,
    top: 50,
    size: 100,
  );

  @Input()
  set item(ClockItem item) {
    _item = item;

    if (_changeStream != null) {
      _changeStream.cancel();
      _changeStream = null;
    }

    _changeStream = _item.onViewChange.listen((_) {
      _updateClock();
    });

    _updateClock();
  }

  StreamSubscription<Null> _changeStream;

  ClockItem get item => _item;

  final _clockComp = ClockComponent();

  ClockItemComponent(HtmlElement root) {
    _updateClock();
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

  void _updateClock() {
    _clockComp.timezone = item.timezone;
    _clockComp.time = DateTime.now();
    _clockComp.textColor = item.textColor;
    _clockComp.color = item.color;
    _clockComp.image = item.imageUrl;
    _clockComp.hourColor = item.hourColor;
    _clockComp.minuteColor = item.minuteColor;
  }

  @override
  void ngOnDestroy() {
    if (_changeStream != null) {
      _changeStream.cancel();
      _changeStream = null;
    }
  }

  @HostBinding('class')
  String get classes => "page-item-clock";
}
