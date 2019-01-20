import 'package:angular/angular.dart';

import 'package:wclient/utils/directives/input_binder.dart';

import 'package:common/models.dart';

@Component(
    selector: 'text-properties',
    styleUrls: ['text_properties.css'],
    templateUrl: 'text_properties.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      TextAreaBinder,
      SelectBoxBinder,
    ],
    exports: [
      Align,
    ])
class TextPropertiesComponent {
  @Input()
  TextItem text = TextItem(
    id: '1',
    name: 'Image1',
    top: 20,
    left: 40,
    width: 200,
    height: 300,
    color: 'blue',
    text: "Some text here!",
  );

  TextPropertiesComponent();
}