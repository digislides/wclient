import 'dart:async';
import 'package:service_worker/worker.dart';

void install() {
  onInstall.listen((InstallEvent event) {
    skipWaiting();
  });
  onActivate.listen((ExtendableEvent event) {
    clients.claim();
  });

  onFetch.listen((FetchEvent event) {
    event.respondWith(_getCachedOrFetch(event.request));
  });
}

Future<Response> _getCachedOrFetch(Request request) async {
  final Response r = await caches.match(request);
  if (r != null) {
    return r;
  }
  return await fetch(request);
}

void main() {
  install();
}
