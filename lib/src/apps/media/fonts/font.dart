import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'info/info.dart';

@Component(
  selector: 'font-list',
  styleUrls: ['font.css'],
  templateUrl: 'font.html',
  directives: [
    NgFor,
    NgIf,
    FontInfoComponent,
  ],
  exports: [
  ],
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
}
