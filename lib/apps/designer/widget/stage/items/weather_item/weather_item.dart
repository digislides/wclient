import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

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
)
class WeatherItemComponent {
  @Input()
  WeatherItem item;

  WeatherItemComponent(HtmlElement root) {
    // TODO
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
