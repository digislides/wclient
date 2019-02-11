import 'package:angular/angular.dart';
import 'package:wclient/apps/home/home.template.dart' as ng;

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

void main() {
  globalClient = BrowserClient();
  runApp(ng.HomeAppNgFactory);
}
