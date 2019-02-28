import 'dart:html';

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

import 'package:common/models.dart';
import 'package:player/preview.dart';

main() async {
  globalClient = BrowserClient();

  ProgramDesign program = ProgramDesign(width: 500, height: 500, frames: [
    Frame(
        id: '1',
        left: 0,
        top: 0,
        width: 200,
        height: 300,
        name: 'Frame1',
        pages: [
          /*
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
              */
          Page(
              id: '2',
              name: 'Page2dfgdfgdfgdfgdfgdfgdfgdfgdfgfdg',
              width: 200,
              height: 300,
              duration: 5,
              fit: Fit.cover,
              items: [
                ClockItem(
                    id: '1',
                    size: 100,
                    left: 5,
                    top: 5,
                    color: 'green',
                    name: 'stockholm'),
              ])
        ])
  ]);

  final view = ProgramView(program);

  document.body.children.add(view.root);
  view.start();
}
