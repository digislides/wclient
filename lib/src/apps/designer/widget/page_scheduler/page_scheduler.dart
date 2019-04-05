import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'week_scheduler/week_scheduler.dart';

@Component(
  selector: 'page-scheduler',
  styleUrls: ['page_scheduler.css'],
  templateUrl: 'page_scheduler.html',
  directives: [
    NgFor,
    NgIf,
    WeekSchedulerComponent,
  ],
)
class PageSchedulerComponent {
  @Input()
  Page page = Page();

  final _closeCont = StreamController();

  Stream _onClose;

  @Output()
  Stream get onClose => _onClose;

  PageSchedulerComponent() {
    _onClose = _closeCont.stream.asBroadcastStream();
  }

  void add() {
    page.schedule.schedule.add(WeekSchedule());
  }

  void close() {
    _closeCont.add(null);
  }
}
