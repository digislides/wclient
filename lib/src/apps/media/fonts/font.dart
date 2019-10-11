import 'dart:html';

import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';
import 'package:wclient/src/utils/directives/input_binder.dart';

import 'info/info.dart';

@Component(
  selector: 'font-list',
  styleUrls: ['font.css'],
  templateUrl: 'font.html',
  directives: [
    NgFor,
    NgIf,
    FontInfoComponent,
    TextBinder,
  ],
  exports: [],
)
class FontListComponent implements OnInit {
  List<MediaFont> fonts = [];

  void ngOnInit() async {
    await update();
  }

  void update() async {
    fonts = await mediaFontApi.getAll("");
  }

  MediaFont showing;

  void closeShowing() async {
    showing = null;
    await update();
  }

  String search = "";

  List<String> tags = [];

  void addTag(InputElement el) {
    final name = el.value;
    if (name.isEmpty || name.contains(RegExp(r"[^a-zA-Z0-9_\-]"))) return;
    tags.add(name);
    el.value = "";
  }
}
