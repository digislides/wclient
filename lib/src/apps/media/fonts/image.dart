import 'package:angular/angular.dart';
import 'package:common/models.dart';
import 'package:common/api/api.dart';

import 'info/info.dart';

@Component(
  selector: 'image-list',
  styleUrls: ['image.css'],
  templateUrl: 'image.html',
  directives: [
    NgFor,
    NgIf,
    ImageInfoComponent,
  ],
  exports: [
  ],
)
class ImageListComponent implements OnInit {
  List<MediaImage> images = [];

  void ngOnInit() async {
    await update();
  }

  void update() async {
    images = await mediaImageApi.getAll("");
  }

  MediaImage showing;

  void closeShowing() async {
    showing = null;
    await update();
  }
}
