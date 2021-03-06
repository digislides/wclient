import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/data/data_repo.dart';
import 'package:common/data/data_weather.dart';

import 'widget/frame_editor/frame_editor.dart';
import 'widget/program_designer/program_designer.dart';

import 'package:common/models.dart';

import 'package:common/api/api.dart';

@Component(
  selector: 'designer-app',
  styleUrls: ['designer.css'],
  templateUrl: 'designer.html',
  directives: [
    NgIf,
    FrameEditorComponent,
    ProgramDesignerComponent,
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
      dataRepository: DataRepository([WeatherData()..register('stockholm')]),
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
                  text: "Hello! {{weather/stockholm/temperature}} World!",
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

  bool editingProgram = false;

  void setProgram(Program program) {
    this.program = program;
    if (this.program.design.frames.isNotEmpty) {
      frame = this.program.design.frames.first;
    } else {
      frame = null;
    }

    program.design.dataRepository.start();
  }

  @override
  Future<void> ngOnInit() async {
    final uri = Uri.parse(window.location.href);
    id = uri.queryParameters['id'];
    Program program = await programApi.getById(id);
    setProgram(program);
  }

  Future<void> save() async {
    await programApi.save(program.id, program.design);
  }

  Future<void> publish() async {
    await programApi.publish(program.id, program.design);
  }

  void editFrame(Frame frame) {
    this.frame = frame;
    editingProgram = false;
  }

  void preview() {
    window.open(
        "/player/program/preview/index.html?id=${program.id}", "_blank");
  }
}
