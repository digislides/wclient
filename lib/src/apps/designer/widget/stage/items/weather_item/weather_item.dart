import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/data/data_repo.dart';

import 'package:common/models.dart';

@Component(
  selector: 'weather-item',
  styleUrls: ['weather_item.css'],
  templateUrl: 'weather_item.html',
  directives: [
    NgFor,
    NgIf,
    NgClass,
  ],
  exports: [
    WeatherIconType,
  ],
)
class WeatherItemComponent implements OnDestroy {
  WeatherItem _item;

  @Input()
  set item(WeatherItem item) {
    _item = item;
    _update(null);
  }

  WeatherItem get item => _item;

  Timer _weatherUpdateTimer;

  WeatherItemComponent(HtmlElement root) {
    _weatherUpdateTimer =
        _weatherUpdateTimer = Timer.periodic(Duration(minutes: 10), _update);
  }

  @HostBinding('style.left.px')
  int get left => item.left;

  @HostBinding('style.top.px')
  int get top => item.top;

  @HostBinding('style.width.px')
  int get width => item.width;

  @HostBinding('style.height.px')
  int get height => item.height;

  @HostBinding('style.color')
  String get color => item.color;

  @HostBinding('class')
  String get classes => "page-item-weather";

  Weather weather = dummyWeather;

  void _update(_) {
    print(item);
    final info =
        item.dataRepository.substitute(DataLink(['weather', item.place], {}));
    if (info.isEmpty) return;
    weather = Weather.serializer.fromMap(jsonDecode(info));
  }

  @override
  void ngOnDestroy() {
    _weatherUpdateTimer.cancel();
  }
}
