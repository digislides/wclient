import 'package:angular/angular.dart';

import '../page_list/page_list.dart';
import '../page_designer/page_designer.dart';

import 'package:common/models.dart';

@Component(
  selector: 'frame-editor',
  styleUrls: ['frame_editor.css'],
  templateUrl: 'frame_editor.html',
  directives: [
    NgIf,
    PageListComponent,
    PageDesignerComponent,
  ],
  exports: [],
)
class FrameEditorComponent {
  Frame _frame = Frame(
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
  set frame(Frame value) {
    _frame = value;
    if (_frame.pages.isEmpty) {
      selectedPage = null;
    } else {
      selectedPage = _frame.pages.first;
    }
  }

  Frame get frame => _frame;

  Page selectedPage;

  void selectPage(Page page) {
    selectedPage = page;
  }
}
