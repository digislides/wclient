import 'package:angular/angular.dart';

import '../stage/stage.dart';

import 'package:common/models.dart';

@Component(
  selector: 'page-editor',
  styleUrls: ['page_editor.css'],
  templateUrl: 'page_editor.html',
  directives: [],
)
class PageEditorComponent {
  Page page;

  PageEditorComponent();
}
