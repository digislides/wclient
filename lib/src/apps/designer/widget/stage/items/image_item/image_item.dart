import 'package:angular/angular.dart';

import 'package:common/models.dart';

@Component(
  selector: 'image-item',
  styleUrls: ['image_item.css'],
  templateUrl: 'image_item.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class ImageItemComponent {
  @Input()
  ImageItem item = ImageItem(
      id: '1',
      name: 'Image',
      left: 100,
      top: 50,
      width: 200,
      height: 150,
      color: 'red',
      url:
          'http://as01.epimg.net/en/imagenes/2018/03/04/football/1520180124_449729_noticia_normal.jpg',
      fit: Fit.cover);

  ImageItemComponent();

  @HostBinding('style.left.px')
  int get left => item.left;

  @HostBinding('style.top.px')
  int get top => item.top;

  @HostBinding('style.width.px')
  int get width => item.width;

  @HostBinding('style.height.px')
  int get height => item.height;

  @HostBinding('style.background-color')
  String get color => item.color;

  @HostBinding('style.background-image')
  String get bgImage => item.imageUrl;

  @HostBinding('style.background-size')
  String get bgSize => item.fit.sizeCss;

  @HostBinding('style.background-repeat')
  String get bgRepeat => item.fit.repeatCss;

  @HostBinding('class')
  String get classes => "page-item-image";
}
