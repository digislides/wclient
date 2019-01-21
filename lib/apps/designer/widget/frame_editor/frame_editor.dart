import 'package:angular/angular.dart';

import '../page_list/page_list.dart';
import '../page_editor/page_editor.dart';

import 'package:common/models.dart';

@Component(
  selector: 'frame-editor',
  styleUrls: ['frame_editor.css'],
  templateUrl: 'frame_editor.html',
  directives: [
    NgIf,
    PageListComponent,
    PageEditorComponent,
  ],
  exports: [PageItemType],
)
class FrameEditorComponent {
  @Input()
  Frame frame;

  Page selectedPage;
}
