import 'dart:html';

import 'package:angular/angular.dart';

import 'media/media.dart';

import 'package:common/models.dart';

import 'package:common/api/api.dart';

@Component(
  selector: 'media-app',
  styleUrls: ['media.css'],
  templateUrl: 'media.html',
  directives: [
    NgIf,
    MediaListComponent,
  ],
)
class MediaApp {}
