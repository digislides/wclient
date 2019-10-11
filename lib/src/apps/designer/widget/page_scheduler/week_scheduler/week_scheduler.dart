import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/src/apps/thumbnail/page/page_thumbnail.dart';

@Component(
  selector: 'week-scheduler',
  styleUrls: ['week_scheduler.css'],
  templateUrl: 'week_scheduler.html',
  directives: [
    NgFor,
    NgIf,
    PageThumbnailComponent,
  ],
)
class WeekSchedulerComponent {
  @Input()
  WeekSchedule schedule = WeekSchedule();

  final _closeCont = StreamController();

  Stream _onClose;

  @Output()
  Stream get onClose => _onClose;

  WeekSchedulerComponent() {
    _onClose = _closeCont.stream.asBroadcastStream();
  }

  void addPeriod() {
    schedule.times.add(TimeInterval());
  }

  void removePeriod(TimeInterval period) {
    schedule.times.remove(period);
  }

  void addDate() {
    schedule.dates.add(DateInterval());
  }

  void removeDate(DateInterval date) {
    schedule.dates.remove(date);
  }

  void delete() {
    _closeCont.add(null);
  }
}
