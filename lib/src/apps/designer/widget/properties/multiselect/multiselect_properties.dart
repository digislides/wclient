import 'dart:async';

import 'package:angular/angular.dart';

@Component(
    selector: 'multiselect-properties',
    styleUrls: ['multiselect_properties.css'],
    templateUrl: 'multiselect_properties.html',
    directives: [
      NgFor,
      NgIf,
    ])
class MultiSelectPropertiesComponent {
  final _emitter = StreamController<String>();

  @Output()
  Stream<String> get action => _emitter.stream.asBroadcastStream();

  MultiSelectPropertiesComponent();

  void send(String action) {
    _emitter.add(action);
  }
}
