import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'stage',
  styleUrls: ['stage.css'],
  templateUrl: 'stage.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class StageComponent {
  StageComponent();
}
