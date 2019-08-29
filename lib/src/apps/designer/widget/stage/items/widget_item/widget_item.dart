import 'package:angular/angular.dart';
import 'package:angular/security.dart';

import 'package:common/models.dart';

@Component(
  selector: 'widget-item',
  styleUrls: ['widget_item.css'],
  templateUrl: 'widget_item.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class WidgetItemComponent {
  @Input()
  WidgetItem item = WidgetItem(
      id: '1',
      name: 'Image',
      left: 100,
      top: 50,
      width: 200,
      height: 150,
      url:
          'http://as01.epimg.net/en/imagenes/2018/03/04/football/1520180124_449729_noticia_normal.jpg');

  DomSanitizationService dss;

  WidgetItemComponent(this.dss);

  @HostBinding('style.left.px')
  int get left => item.left;

  @HostBinding('style.top.px')
  int get top => item.top;

  @HostBinding('style.width.px')
  int get width => item.width;

  @HostBinding('style.height.px')
  int get height => item.height;

  @HostBinding('class')
  String get classes => "page-item-image";

  SafeResourceUrl _safeUrl;
  String _oldUrl;

  SafeResourceUrl get url {
    if (_oldUrl == item.url) return _safeUrl;
    _oldUrl = item.url;
    if (item.url == null || item.url.isEmpty) {
      _safeUrl = null;
    } else {
      _safeUrl = dss.bypassSecurityTrustResourceUrl(item.url);
    }
    return _safeUrl;
  }

  SafeHtml _safeSrcDoc;
  String _oldSrcDoc;

  SafeHtml get srcdoc {
    if (_oldSrcDoc == item.url) return _safeSrcDoc;
    _oldSrcDoc = item.url;
    _safeSrcDoc = dss.bypassSecurityTrustHtml(item.asSrcDoc);
    return _safeSrcDoc;
  }
}
