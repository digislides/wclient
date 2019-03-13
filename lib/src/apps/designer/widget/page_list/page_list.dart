import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/models.dart';

@Component(
  selector: 'page-list',
  styleUrls: ['page_list.css'],
  templateUrl: 'page_list.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class PageListComponent {
  @Input()
  Frame frame = Frame(
      id: '1',
      left: 0,
      top: 0,
      width: 200,
      height: 300,
      name: 'Frame1',
      pages: [
        Page(
            id: '1',
            name: 'Page1sdfsdfsdf sdfsdfsd sdfsdfsdf',
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
            ]),
        Page(
            id: '2',
            name: 'Page2dfgdfgdfgdfgdfgdfgdfgdfgdfgfdg',
            width: 200,
            height: 300,
            duration: 5,
            fit: Fit.cover,
            items: [
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
            ])
      ]);

  @Input()
  Page selectedPage;

  @ViewChild('items')
  DivElement itemsDiv;

  PageListComponent();

  int counter = 0;

  void addPage() {
    frame.addNewPage(name: "New page ${counter++}");
  }

  void deletePage(Page page) {
    if (selectedPage == page) {
      // If the page being removed is currently, select a new page
      selectPage(frame.pages.firstWhere((p) => p != page, orElse: () => null));
    }
    frame.removePage(page.id);
  }

  void duplicatePage(Page page) {
    frame.duplicatePage(page.id);
  }

  Page dragging;

  Page draggingOn;

  void onDragStart(MouseEvent event, Page page) {
    dragging = page;
    int nextIndex = frame.pages.indexOf(page) + 1;
    if (nextIndex < frame.pages.length) {
      draggingOn = frame.pages[nextIndex];
    } else {
      draggingOn = null;
    }
  }

  void onDragOverItem(MouseEvent event, Page page) {
    if (dragging != null && event.buttons == 1) {
      if (page != null) {
        if (page != draggingOn) {
          draggingOn = page;
        } else {
          draggingOn = page;
          int nextIndex = frame.pages.indexOf(page) + 1;
          if (nextIndex < frame.pages.length) {
            draggingOn = frame.pages[nextIndex];
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
        frame.movePageTo(dragging.id, frame.pages.indexOf(draggingOn));
      } else {
        frame.movePageTo(dragging.id, frame.pages.length);
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

  final _pageSelCntr = StreamController<Page>();

  @Output()
  Stream<Page> get onPageSelect => _pageSelCntr.stream;

  void selectPage(Page page) {
    _pageSelCntr.add(page);
  }
}
