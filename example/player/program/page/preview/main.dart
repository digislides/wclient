import 'dart:html';

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

import 'package:common/models.dart';
import 'package:common/api/api.dart';
import 'package:player/ui/page.dart';

main() async {
  globalClient = BrowserClient();

  final uri = Uri.parse(window.location.href);
  String id = uri.queryParameters['id'];
  String frameId = uri.queryParameters['frame'];
  String pageId = uri.queryParameters['page'];

  Program program = await programApi.getById(id);
  if (program == null) {
    print('No program!');
    return;
  }

  final frame = program.design.frames
      .firstWhere((f) => f.id == frameId, orElse: () => null);
  if (frame == null) {
    print('No frame!');
    return;
  }

  final page =
      frame.pages.firstWhere((p) => p.id == pageId, orElse: () => null);
  if (page == null) {
    print('No page!');
    return;
  }

  final view = PageView(page, Transition.none);

  document.body.children.add(view.root);
  await view.play();
}
