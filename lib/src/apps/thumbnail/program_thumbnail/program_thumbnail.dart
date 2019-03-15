import 'package:angular/angular.dart';
import 'package:common/models.dart';

import 'package:wclient/src/apps/thumbnail/frame/frame_thumbnail.dart';

@Component(
  selector: 'program-thumbnail',
  styleUrls: ['program_thumbnail.css'],
  templateUrl: 'program_thumbnail.html',
  directives: [
    NgFor,
    NgIf,
    FrameThumbnailComponent,
  ],
)
class ProgramThumbnailComponent {
  ProgramDesign _program;

  @Input()
  set program(ProgramDesign value) {
    _program = value;
    _resize();
  }

  ProgramDesign get program => _program;

  int _width;

  @Input()
  set width(int value) {
    _width = value;
    _resize();
  }

  int get width => _width;

  int _height;

  @Input()
  set height(int value) {
    _height = value;
    _resize();
  }

  int get height => _height;

  double scale;

  @HostBinding('style.width.px')
  int scaledWidth = 0;

  @HostBinding('style.height.px')
  int scaledHeight = 0;

  String transform;

  void _resize() {
    if (_program != null && _width != null && _height != null) {
      double scaleX = _width / _program.width;
      double scaleY = _height / _program.height;
      if (scaleX < scaleY) {
        scale = scaleX;
      } else {
        scale = scaleY;
      }
    } else {
      scale = 1;
    }
    if (_program != null) {
      scaledWidth = (scale * _program.width).toInt();
      scaledHeight = (scale * _program.height).toInt();
    } else {
      scaledWidth = 0;
      scaledHeight = 0;
    }

    transform = "scale($scale, $scale)";
  }
}
