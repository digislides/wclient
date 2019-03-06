import 'dart:html';

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

import 'package:common/models.dart';
import 'package:player/preview.dart';
import 'package:wclient/utils/api/api.dart';

import 'package:player/service_worker/service_window.dart';
import 'package:player/persistent_storage/persistent_storage.dart';
import 'package:service_worker/window.dart' as sw;

String id;

ProgramView view;

ContentStorage storage;

String version;

void update() async {
  // Get latest version of content we are supposed to run
  String latestVersion = await channelApi.getVersion(id);

  // Check if we are already running latest content
  if (latestVersion == version) {
    print("Already have content!");
    return;
  }

  // Check if we have the version in content storage
  PublishedProgram pub = await storage.getContentById(id);
  if (pub == null || pub.id != latestVersion) {
    print("Fetching new content!");
    // Fetch new content
    pub = await channelApi.getContent(id);
    // Persist new content
    await storage.saveContent(id, pub);

    Future.microtask(
        () async => await channelApi.setPlaying(id, latestVersion));
  }

  // Cache media
  if(pub != null && pub.design != null) {
    await cacheProgramUrls(id, pub.design);
    version = pub.id;
  } else {
    version = "None";
  }

  print("Showing new content!");

  if (view != null) view.purge();

  if (pub != null && pub.design != null) {
    view = ProgramView(pub.design);
    document.body.children.add(view.root);
    view.start();
  }
}

main() async {
  globalClient = BrowserClient();

  storage = await ContentStorage.connect();

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

  final es = EventSource('/api/channel/$id/rt');
  window.onUnload.listen((_) {
    es.close();
  });
  es.addEventListener('publish', (m) async {
    print("Received update notification ...");
    await update();
  });
  es.onMessage.listen((m) async {
    print("Received message ...");
  });
  Future.delayed(Duration(seconds: 10), () {
    es.close();
  });
}
