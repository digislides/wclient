import 'dart:html';

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

import 'package:common/models.dart';
import 'package:player/preview.dart';
import 'package:wclient/utils/api/api.dart';

import 'package:player/service_worker/service_window.dart';
import 'package:service_worker/window.dart' as sw;

main() async {
  globalClient = BrowserClient();

  try {
    final cacher = (await sw.getRegistrations()).firstWhere((reg) {
      if (reg.active != null)
        return reg.active.scriptURL == '/player/sw.dart.js';
      return false;
    }, orElse: () => null);
    if (cacher == null) {
      await sw.register('/player/sw.dart.js');
      sw.ready.then((sw.ServiceWorkerRegistration reg) {
        print("Registered!");
      });
    } else {
      cacher.onUpdateFound.listen((_) {
        print("Update found!");
        // cacher.update();
      });
      cacher.update();
    }
  } catch (e) {}

  final uri = Uri.parse(window.location.href);
  String id = uri.queryParameters['id'];

  Program program = await programApi.getById(id);
  if (program == null) {
    print('No program!');
    return;
  }

  // print(program.design);

  await cacheProgramUrls(id, program.design);

  final view = ProgramView(program.design);

  document.body.children.add(view.root);
  view.start();
}
