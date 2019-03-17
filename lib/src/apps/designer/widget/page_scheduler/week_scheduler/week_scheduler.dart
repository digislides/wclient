import 'dart:async';
import 'dart:html';
import 'dart:math';

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
  WeekSchedule schedule = WeekSchedule();

  void addPeriod() {
    schedule.times.add(TimeInterval(0, 0));
  }

  void removePeriod(TimeInterval period) {
    schedule.times.remove(period);
  }
}
