import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

import '../stage/stage.dart';

@Component(
  selector: 'item-list',
  styleUrls: ['item_list.css'],
  templateUrl: 'item_list.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class ItemListComponent {
  @Input()
  Page page;

  @Input()
  Iterable<PageItem> selectedItems;

  @ViewChild('items')
  DivElement itemsDiv;

  ItemListComponent();

  int counter = 0;

  void deleteItem(PageItem item) {
    if (selectedItems.contains(item)) {
      // TODO remove
    }
    page.removeItem(item.id);
  }

  void duplicateItem(PageItem item) {
    page.duplicateItem(item.id);
  }

  PageItem dragging;

  PageItem draggingOn;

  void onDragStart(MouseEvent event, PageItem item) {
    dragging = item;
    int nextIndex = page.items.indexOf(item) + 1;
    if (nextIndex < page.items.length) {
      draggingOn = page.items[nextIndex];
    } else {
      draggingOn = null;
    }
  }

  void onDragOverItem(MouseEvent event, PageItem item) {
    if (dragging != null && event.buttons == 1) {
      if (item != null) {
        if (item != draggingOn) {
          draggingOn = item;
        } else {
          draggingOn = item;
          int nextIndex = page.items.indexOf(item) + 1;
          if (nextIndex < page.items.length) {
            draggingOn = page.items[nextIndex];
          } else {
            draggingOn = null;
          }
        }
      } else {
        draggingOn = null;
      }
    }
  }

  void onDrop(MouseEvent event) {
    if (dragging != null) {
      if (draggingOn != null) {
        page.moveItemTo(dragging.id, page.items.indexOf(draggingOn));
      } else {
        page.moveItemTo(dragging.id, page.items.length);
      }
      dragging = null;
      draggingOn = null;
    }
  }

  @HostListener('mouseleave')
  void onMouseLeave(MouseEvent event) {
    if (dragging != null) {
      dragging = null;
      draggingOn = null;
    }
  }

  void onKeyPress(KeyboardEvent event) {
    if (dragging != null) {
      if (event.keyCode == KeyCode.ESC) {
        dragging = null;
        draggingOn = null;
      }
    }
  }

  void autoScroll(MouseEvent event) {
    if (dragging != null && event.buttons == 1) {
      final target = (event.target as Element);
      int y = target.offsetTop -
          itemsDiv.scrollTop -
          itemsDiv.offsetTop +
          event.offset.y;
      if (y < 50) {
        itemsDiv.scrollTop -= 10;
      } else if (y > (itemsDiv.offsetHeight - 50)) {
        itemsDiv.scrollTop += 10;
      }
    }
  }

  final _itemSelCntr = StreamController<PageItemSelectionEvent>();

  @Output()
  Stream<PageItemSelectionEvent> get onItemSelect => _itemSelCntr.stream;

  void selectItem(MouseEvent e, PageItem item) {
    _itemSelCntr.add(PageItemSelectionEvent(item, e.shiftKey));
  }
}
