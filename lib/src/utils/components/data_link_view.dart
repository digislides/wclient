import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:common/data/data_repo.dart';

void _dummy() => null;

class DataLinkView {
  final DataLink dataLink;

  final root = SpanElement();

  final VoidCallback onDelete;

  final VoidCallback onEdit;

  DataLinkView(this.dataLink, {this.onDelete: _dummy, this.onEdit: _dummy}) {
    _build();
  }

  final _actions = DivElement();

  void _build() {
    root.classes.add('data-link-view');
    root.contentEditable = 'false';
    root.onKeyDown.listen((e) {
      e.preventDefault();
      e.stopPropagation();
    });
    root.onClick.listen((_) {
      _actions.classes.add('show');
    });

    root.text = dataLink.path;
    root.title = dataLink.path;

    root.dataset['path'] = jsonEncode(dataLink.segments);
    root.dataset['args'] = jsonEncode(dataLink.args);

    _actions
      ..children.addAll([
        SpanElement()
          ..classes
              .addAll(['data-link-view-action', 'data-link-view-action-edit'])
          ..onClick.listen((e) {
            _actions.classes.remove('show');
            e.stopPropagation();
            onEdit();
          })
          ..title = 'Edit'
          ..text = '\u270E',
        SpanElement()
          ..classes
              .addAll(['data-link-view-action', 'data-link-view-action-copy'])
          ..onClick.listen((_) => copyClicked())
          ..title = 'Copy'
          ..text = '\u{2398}',
        SpanElement()
          ..classes
              .addAll(['data-link-view-action', 'data-link-view-action-delete'])
          ..onClick.listen((e) {
            _actions.classes.remove('show');
            e.stopPropagation();
            onDelete();
          })
          ..title = 'Delete'
          ..text = '\u2326',
        SpanElement()
          ..classes
              .addAll(['data-link-view-action', 'data-link-view-action-close'])
          ..onClick.listen((e) {
            _actions.classes.remove('show');
            e.stopPropagation();
          })
          ..title = 'Close'
          ..text = '\u2715',
      ])
      ..classes.add('data-link-view-actions');

    root.children.add(_actions);
  }

  void copyClicked() {
    final tempInp = InputElement()..value = dataLink.toString();
    document.body.children.add(tempInp);
    tempInp.select();
    document.execCommand('copy');
    tempInp.remove();
    // TODO
  }
}
