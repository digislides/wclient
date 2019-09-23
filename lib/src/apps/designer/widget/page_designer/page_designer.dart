import 'package:angular/angular.dart';
import 'package:wclient/src/apps/designer/widget/properties/widget/widget_properties.dart';

import '../stage/stage.dart';
import '../properties/page/page_properties.dart';
import '../properties/multiselect/multiselect_properties.dart';
import '../properties/image/image_properties.dart';
import '../properties/text/text_properties.dart';
import '../properties/clock/clock_properties.dart';
import '../properties/video/video_properties.dart';
import '../properties/weather/weather_properties.dart';
import '../properties/scroller/scroller_properties.dart';
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
    WeatherPropertiesComponent,
    WidgetPropertiesComponent,
    ScrollerPropertiesComponent,
    MultiSelectPropertiesComponent,
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
    stage.setSelection(PageItemSelectionEvent(item, false));
  }

  int selectedTab = 0;

  void selectItem(PageItemSelectionEvent e) {
    stage.setSelection(e);
  }

  void onMultiSelectAction(String action) {
    if(action.startsWith('align-')) {
      align(action);
    } else if(action.startsWith('dist-')) {
      distributer(action);
    } else if(action.startsWith('size-')) {
      sizer(action);
    }
  }

  void align(String where) {
    switch (where) {
      case 'align-top':
        if (selected.isNotEmpty) {
          final top = selected.first.top;
          for (PageItem item in selected) {
            item.top = top;
          }
        }
        break;
      case 'align-mid':
        if (selected.isNotEmpty) {
          final mid =
              selected.first.top + (selected.first.height ~/ 2);
          for (PageItem item in selected) {
            item.top = mid - (item.height ~/ 2);
          }
        }
        break;
      case 'align-bottom':
        if (selected.isNotEmpty) {
          final bottom =
              selected.first.top + selected.first.height;
          for (PageItem item in selected) {
            item.top = bottom - item.height;
          }
        }
        break;
      case 'align-left':
        if (selected.isNotEmpty) {
          final left = selected.first.left;
          for (PageItem item in selected) {
            item.left = left;
          }
        }
        break;
      case 'align-center':
        if (selected.isNotEmpty) {
          final center =
              selected.first.left + (selected.first.width ~/ 2);
          for (PageItem item in selected) {
            item.left = center - (item.width ~/ 2);
          }
        }
        break;
      case 'align-right':
        if (selected.isNotEmpty) {
          final right =
              selected.first.left + selected.first.width;
          for (PageItem item in selected) {
            item.left = right - item.width;
          }
        }
        break;
    }
  }

  void sizer(String where) {
    switch (where) {
      case 'size-width':
        if (selected.isNotEmpty) {
          final newWidth = selected.first.width;
          for (PageItem item in selected) {
            item.width = newWidth;
          }
        }
        break;
      case 'size-height':
        if (selected.isNotEmpty) {
          final newHeight = selected.first.height;
          for (PageItem item in selected) {
            item.height = newHeight;
          }
        }
        break;
      case 'size-width-ratio':
        if (selected.isNotEmpty) {
          final newWidth = selected.first.width;
          for (PageItem item in selected) {
            double ratio = item.height/item.width;
            item.width = newWidth;
            item.height = (ratio * newWidth).toInt();
          }
        }
        break;
      case 'size-height-ratio':
        if (selected.isNotEmpty) {
          final newHeight = selected.first.height;
          for (PageItem item in selected) {
            double ratio = item.width/item.height;
            item.height = newHeight;
            item.width = (ratio * newHeight).toInt();
          }
        }
        break;
      case 'size-extend-width':
        if (selected.isNotEmpty) {
          for (PageItem item in selected) {
            final newWidth = page.width - item.left;
            if (newWidth > 0) item.width = newWidth;
          }
        }
        break;
      case 'size-extend-height':
        if (selected.isNotEmpty) {
          for (PageItem item in selected) {
            final newHeight = page.height - item.top;
            if (newHeight > 0) item.height = newHeight;
          }
        }
        break;
      case 'size-extend-width-ratio':
        if (selected.isNotEmpty) {
          for (PageItem item in selected) {
            final newWidth = page.width - item.left;

            if (newWidth <= 0) continue;
            double ratio = item.height / item.width;
            item.width = newWidth;
            item.height = (ratio * newWidth).toInt();
          }
        }
        break;
      case 'size-extend-height-ratio':
        if (selected.isNotEmpty) {
          for (PageItem item in selected) {
            final newHeight = page.height - item.top;
            if (newHeight <= 0) continue;
            double ratio = item.width / item.height;
            item.height = newHeight;
            item.width = (ratio * newHeight).toInt();
          }
        }
        break;
    }
  }

  void distributer(String where) {
    switch (where) {
      case 'dist-h':
        if (selected.length > 2) {
          final sorted = selected.toList()
            ..sort((a, b) => a.left - b.left);

          int gap = 0;

          PageItem bef;

          for (final item in sorted) {
            if (bef != null) {
              gap += item.left - (bef.left + bef.width);
            }
            bef = item;
          }

          gap = modn(gap, selected.length - 1);

          bef = null;

          for (final item in sorted) {
            if (bef != null) {
              item.left = bef.left + bef.width + gap;
            }
            bef = item;
          }
        }
        break;
      case 'dist-htouch':
        if (selected.length > 1) {
          final sorted = selected.toList()
            ..sort((a, b) => a.left - b.left);

          PageItem bef;

          for (final item in sorted) {
            if (bef != null) {
              item.left = bef.left + bef.width;
            }
            bef = item;
          }
        }
        break;
      case 'dist-hwide':
        if (selected.length > 2) {
          final sorted = selected.toList()
            ..sort((a, b) => a.left - b.left);

          int gap = 0;

          PageItem bef;

          for (final item in sorted) {
            if (bef != null) {
              gap += item.left - (bef.left + bef.width);
            }
            bef = item;
          }

          gap = modn(gap, selected.length - 1);
          gap += 5;

          bef = null;

          for (final item in sorted) {
            if (bef != null) {
              item.left = bef.left + bef.width + gap;
            }
            bef = item;
          }
        }
        break;
      case 'dist-hcontract':
        if (selected.length > 2) {
          final sorted = selected.toList()
            ..sort((a, b) => a.left - b.left);

          int gap = 0;

          PageItem bef;

          for (final item in sorted) {
            if (bef != null) {
              gap += item.left - (bef.left + bef.width);
            }
            bef = item;
          }

          gap = modn(gap, selected.length - 1);
          gap -= 5;

          bef = null;

          for (final item in sorted) {
            if (bef != null) {
              item.left = bef.left + bef.width + gap;
            }
            bef = item;
          }
        }
        break;
      case 'dist-v':
        if (selected.length > 2) {
          final sorted = selected.toList()
            ..sort((a, b) => a.top - b.top);

          int gap = 0;

          PageItem bef;

          for (final item in sorted) {
            if (bef != null) {
              gap += item.top - (bef.top + bef.height);
            }
            bef = item;
          }

          gap = gap ~/ (selected.length - 1);
          bef = null;

          for (final item in sorted) {
            if (bef != null) {
              item.top = bef.top + bef.height + gap;
            }
            bef = item;
          }
        }
        break;
      case 'dist-vtouch':
        if (selected.length > 1) {
          final sorted = selected.toList()
            ..sort((a, b) => a.top - b.top);

          PageItem bef;

          for (final item in sorted) {
            if (bef != null) {
              item.top = bef.top + bef.height;
            }
            bef = item;
          }
        }
        break;
      case 'dist-vwide':
        if (selected.length > 2) {
          final sorted = selected.toList()
            ..sort((a, b) => a.top - b.top);

          int gap = 0;

          PageItem bef;

          for (final item in sorted) {
            if (bef != null) {
              gap += item.top - (bef.top + bef.height);
            }
            bef = item;
          }

          gap = gap ~/ (selected.length - 1);
          gap += 5;

          bef = null;

          for (final item in sorted) {
            if (bef != null) {
              item.top = bef.top + bef.height + gap;
            }
            bef = item;
          }
        }
        break;
      case 'dist-vcontract':
        if (selected.length > 2) {
          final sorted = selected.toList()
            ..sort((a, b) => a.top - b.top);

          int gap = 0;

          PageItem bef;

          for (final item in sorted) {
            if (bef != null) {
              gap += item.top - (bef.top + bef.height);
            }
            bef = item;
          }

          gap = gap ~/ (selected.length - 1);
          gap -= 5;

          bef = null;

          for (final item in sorted) {
            if (bef != null) {
              item.top = bef.top + bef.height + gap;
            }
            bef = item;
          }
        }
        break;
    }
  }
}
