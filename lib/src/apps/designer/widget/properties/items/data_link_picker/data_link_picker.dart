import 'dart:async';

import 'package:angular/angular.dart';

import 'package:wclient/src/utils/directives/input_binder.dart';

import 'package:common/models.dart';
import 'package:common/data/data_repo.dart';

@Component(
    selector: 'data-link-picker',
    styleUrls: ['data_link_picker.css'],
    templateUrl: 'data_link_picker.html',
    directives: [
      NgFor,
      NgIf,
      TextBinder,
      SelectBoxBinder,
    ],
    exports: [
      Fit,
    ])
class DataLinkPickerComponent {
  @Input()
  set repo(DataRepository value) {
    _repo = value;
    defPeek = _repo.definitions;
  }

  @Input()
  set link(DataLink value) {
    defPeek = def.query(value);
  }

  DataDefBranch get def => _repo.definitions;

  DataRepository _repo;

  DataDefTree defPeek;

  bool get defPeekIsBranch => defPeek is DataDefBranch;

  DataDefBranch get defPeekAsBranch => defPeek as DataDefBranch;

  bool get defPeekIsLeaf => defPeek is DataDefLeaf;

  DataDefLeaf get defPeekAsLeaf => defPeek as DataDefLeaf;

  void home() {
    defPeek = def;
  }

  void quit() {
    _finishEmitter.add(null);
  }

  void apply() {
    DataLink ret = DataLink(defPeek.segments.toList(), {});
    _finishEmitter.add(ret.toString());
  }

  StreamController<String> _finishEmitter = StreamController<String>();

  @Output()
  Stream<String> get finish => _finishEmitter.stream;
}
