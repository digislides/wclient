import 'package:angular/angular.dart';
import 'package:wclient/src/apps/media/media.template.dart' as ng;

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

void main() {
  globalClient = BrowserClient();
  runApp(ng.MediaAppNgFactory);
}
