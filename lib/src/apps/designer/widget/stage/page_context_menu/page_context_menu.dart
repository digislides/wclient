import 'dart:math';
import 'dart:async';

import 'package:angular/angular.dart';


@Component(
  selector: 'page-context-menu',
  styleUrls: ['page_context_menu.css'],
  templateUrl: 'page_context_menu.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class PageContextMenuComponent {
  @Input()
  Point<int> position = Point<int>(0, 0);

  @Input()
  bool hasSelection = false;

  final _actionEmitter = StreamController<String>();

  @Output()
  Stream<String> get action => _actionEmitter.stream;

  void send(String action) {
    _actionEmitter.add(action);
  }

  @HostBinding('style.left.px')
  String get left => '${position.x}';

  @HostBinding('style.top.px')
  String get top => '${position.y}';
}
