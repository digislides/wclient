import 'dart:async';

import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

@Component(
  selector: 'timezone-prop',
  styleUrls: ['timezone.css'],
  templateUrl: 'timezone.html',
  directives: [
    NgFor,
    NgIf,
    TextBinder,
    SelectBoxBinder,
  ],
)
class TimezonePropComponent {
  @Input()
  Duration zone;

  @Output()
  Stream<Duration> get onChange => _onChange;

  final _onChangeCont = StreamController<Duration>();

  Stream<Duration> _onChange;

  TimezonePropComponent() {
    _onChange = _onChangeCont.stream.asBroadcastStream();
  }

  void changed(String value) {
    _onChangeCont.add(fromZoneStr(value));
  }

  String get zoneStr {
    int hours = zone.inHours.abs() % 24;

    int minutes = zone.inMinutes.abs() % 60;

    final sb = StringBuffer();

    if (zone.inHours.isNegative)
      sb.write('-');
    else
      sb.write('+');

    if (hours < 10) sb.write('0');
    sb.write(hours);
    sb.write(':');
    if (minutes < 10) sb.write('0');
    sb.write(minutes);

    return sb.toString();
  }

  Duration fromZoneStr(String v) {
    final parts = v.split(':');
    if (parts.length != 2) return Duration();

    int hours = int.tryParse(parts.first);
    if (hours == null) return Duration();

    int minutes = int.tryParse(parts.last);
    if (minutes == null) return Duration();

    minutes += (hours.abs() * 60);
    if (hours.isNegative) minutes = -minutes;

    return Duration(minutes: minutes);
  }
}
