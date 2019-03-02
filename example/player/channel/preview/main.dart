import 'dart:html';

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

import 'package:player/preview.dart';
import 'package:wclient/utils/api/api.dart';

import 'package:player/service_worker/service_window.dart';
import 'package:service_worker/window.dart' as sw;

String id;

ProgramView view;

void update() async {
  final pub = await channelApi.getContent(id);

  await cacheProgramUrls(id, pub.design);

  final thisView = ProgramView(pub.design);
  if (view != null) view.purge();

  view = thisView;
  document.body.children.add(view.root);

  view.start();
}

main() async {
  globalClient = BrowserClient();

  try {
    final cacher = (await sw.getRegistrations()).firstWhere((reg) {
      if (reg.active != null)
        return reg.active.scriptURL == '/player/channel/play/sw.dart.js';
      return false;
    }, orElse: () => null);
    if (cacher == null) {
      await sw.register('/player/channel/play/sw.dart.js');
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
  id = uri.queryParameters['id'];

  await update();
}
