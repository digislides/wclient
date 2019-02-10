import 'dart:html';

import 'package:angular/angular.dart';

import 'widget/frame_editor/frame_editor.dart';

import 'package:common/models.dart';

import 'package:wclient/utils/api/api.dart';

@Component(
  selector: 'designer-app',
  styleUrls: ['designer.css'],
  templateUrl: 'designer.html',
  directives: [
    NgIf,
    FrameEditorComponent,
  ],
)
class DesignerApp implements OnInit {
  Program program;

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

  String id;

  void setProgram(Program program) {
    this.program = program;
    if (this.program.design.frames.isNotEmpty) {
      frame = this.program.design.frames.first;
    } else {
      frame = null;
    }
  }

  @override
  Future<void> ngOnInit() async {
    print(window.location.href);
    final uri = Uri.parse(window.location.href);
    id = uri.queryParameters['id'];
    Program program = await programApi.getById(id);
    print(program);
    setProgram(program);
  }

  Future<void> save() async {
    await programApi.save(program.id, program.design);
  }
}
