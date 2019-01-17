import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'properties',
  styleUrls: ['properties.css'],
  templateUrl: 'properties.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class StageComponent {
  StageComponent();
}
