import 'package:angular/angular.dart';

import '../stage/stage.dart';
import '../properties/page/page_properties.dart';
import '../properties/image/image_properties.dart';
import '../properties/text/text_properties.dart';
import '../properties/clock/clock_properties.dart';
import '../properties/video/video_properties.dart';
import '../item_list/item_list.dart';

import 'package:common/models.dart';

@Component(
  selector: 'page-designer',
  styleUrls: ['page_designer.css'],
  templateUrl: 'page_designer.html',
  directives: [
    NgIf,
    PageStageComponent,
    PagePropertiesComponent,
    TextPropertiesComponent,
    ImagePropertiesComponent,
    VideoPropertiesComponent,
    ClockPropertiesComponent,
    ItemListComponent,
  ],
  exports: [PageItemType],
)
class PageDesignerComponent {
  @Input()
  Page page = Page(
      id: '1',
      name: 'Page1',
      width: 200,
      height: 300,
      duration: 5,
      fit: Fit.cover,
      items: [
        TextItem(
            id: '0',
            text: "Hello!",
            left: 10,
            top: 20,
            width: 100,
            height: 50,
            color: 'red',
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

  @ViewChild(PageStageComponent)
  PageStageComponent stage;

  PageDesignerComponent();

  Iterable<PageItem> selected = [];

  PageItem get firstSelected => selected.first;

  void selectionChanged(Iterable<PageItem> items) {
    selected = items;
  }

  void onItemAdd(PageItem item) {
    stage.setSelection(item);
  }

  int selectedTab = 0;
}
