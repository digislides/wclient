import 'dart:html';

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

import 'package:common/models.dart';
import 'package:player/preview.dart';
import 'package:common/api/api.dart';

main() async {
  globalClient = BrowserClient();

  final uri = Uri.parse(window.location.href);
  String id = uri.queryParameters['id'];

  Program program = await programApi.getById(id);
  if (program == null) {
    print('No program!');
    return;
  }

  final view = ProgramView(program.design);

  document.body.children.add(view.root);
  view.start();
}
