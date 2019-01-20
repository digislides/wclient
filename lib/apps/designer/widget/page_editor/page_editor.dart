import 'package:angular/angular.dart';

import '../stage/stage.dart';
import '../properties/page/page_properties.dart';
import '../properties/image/image_properties.dart';

import 'package:common/models.dart';

@Component(
  selector: 'page-editor',
  styleUrls: ['page_editor.css'],
  templateUrl: 'page_editor.html',
  directives: [
    NgIf,
    PageStageComponent,
    PagePropertiesComponent,
    ImagePropertiesComponent,
  ],
  exports: [PageItemType],
)
class PageEditorComponent {
  @Input()
  Page page = Page(
      id: '1',
      name: 'Page1',
      width: 200,
      height: 300,
      duration: 5,
      color: 'green',
      items: [
        TextItem(
            id: '0',
            text: "Hello!",
            left: 10,
            top: 20,
            width: 100,
            height: 50,
            bgColor: 'red',
            font: FontProperties(size: 25)),
        ImageItem(
            id: '1',
            name: 'Image',
            left: 10,
            top: 50,
            width: 150,
            height: 100,
            url:
                'http://as01.epimg.net/en/imagenes/2018/03/04/football/1520180124_449729_noticia_normal.jpg',
            fit: Fit.cover),
      ]);

  PageEditorComponent();

  Iterable<PageItem> selected = [];

  PageItem get firstSelected => selected.first;

  void selectionChanged(Iterable<PageItem> items) {
    selected = items;
  }
}
