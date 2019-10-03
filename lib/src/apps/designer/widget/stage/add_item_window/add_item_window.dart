import 'dart:async';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
  selector: 'add-item-window',
  styleUrls: ['add_item_window.css'],
  templateUrl: 'add_item_window.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
  ],
)
class AddItemWindowComponent {
  final _actionEmitter = StreamController<PageItem>();

  @Output()
  Stream<PageItem> get action => _actionEmitter.stream;

  void send(String type) {
    switch (type) {
      case 'text':
        final item = TextItem();
        _actionEmitter.add(item);
        break;
      case 'image':
        final item = ImageItem();
        _actionEmitter.add(item);
        break;
      case 'video':
        final item = VideoItem();
        _actionEmitter.add(item);
        break;
      case 'clock':
        final item = ClockItem();
        _actionEmitter.add(item);
        break;
      case 'weather':
        final item = WeatherItem();
        _actionEmitter.add(item);
        break;
      case 'widget':
        final item = WidgetItem();
        _actionEmitter.add(item);
        break;
      case 'scroller':
        final item = ScrollerItem();
        _actionEmitter.add(item);
        break;
    }
  }
}
