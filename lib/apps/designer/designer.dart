import 'package:angular/angular.dart';

import 'widget/frame_editor/frame_editor.dart';

import 'package:common/models.dart';

@Component(
  selector: 'designer-app',
  styleUrls: ['designer.css'],
  templateUrl: 'designer.html',
  directives: [FrameEditorComponent],
)
class DesignerApp {
  /// The frame currently being edited
  @Input()
  Frame frame;
}
