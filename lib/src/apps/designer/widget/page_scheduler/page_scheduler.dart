import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/src/apps/thumbnail/page/page_thumbnail.dart';

@Component(
  selector: 'page-scheduler',
  styleUrls: ['page_scheduler.css'],
  templateUrl: 'page_scheduler.html',
  directives: [
    NgFor,
    NgIf,
    PageThumbnailComponent,
  ],
)
class PageSchedulerComponent {
  PageSchedule schedule = PageSchedule();
}
