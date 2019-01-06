import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'image-item',
  styleUrls: ['image_item.css'],
  templateUrl: 'image_item.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class ImageItemComponent {
  ImageItemComponent();
}
