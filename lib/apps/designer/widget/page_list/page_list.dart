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
            ]),
        Page(
            id: '2',
            name: 'Page2',
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

  PageListComponent();

  void addPage() {
    frame.addNewPage();
  }

  void deletePage(Page page) {
    if (selectedPage == page) {
      // TODO if its selected, set new selected page
    }
    frame.removePage(page.id);
  }

  void duplicatePage(Page page) {
    // frame.
    // TODO
  }
}
