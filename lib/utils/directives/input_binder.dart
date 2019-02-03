import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Directive(
  selector: '[tjText]',
)
class TextBinder {
  final InputElement _host;

  final _valChanged = StreamController<String>();

  TextBinder(Element el) : _host = el;

  @Input()
  set bind(value) {
    _host.value = value?.toString() ?? '';
  }

  @Output()
  Stream<String> get bind => _valChanged.stream;

  String _oldValue;

  @HostListener('focus')
  void onFocus(_) {
    _oldValue = _host.value;
  }

  @HostListener('blur')
  void onBlur(_) {
    _valChanged.add(_host.value);
  }

  @HostListener('keyup')
  void onKeyUp(final event) {
    if (event is KeyboardEvent) {
      if (event.keyCode == KeyCode.ENTER) {
        _valChanged.add(_host.value);
      } else if (event.keyCode == KeyCode.ESC) {
        _host.value = _oldValue;
      }
    }
  }
}

@Directive(
  selector: '[tjNum]',
)
class NumBinder {
  final InputElement _host;

  final _valChanged = StreamController<int>();

  NumBinder(Element el) : _host = el;

  @Input()
  set bind(value) {
    _host.value = value?.toString() ?? '';
  }

  @Output()
  Stream<int> get bind => _valChanged.stream;

  String _oldValue;

  @HostListener('focus')
  void onFocus(_) {
    _oldValue = _host.value;
  }

  @HostListener('blur')
  void onBlur(_) {
    _send();
  }

  @HostListener('keyup')
  void onKeyUp(final event) {
    if (event is KeyboardEvent) {
      if (event.keyCode == KeyCode.ENTER) {
        _send();
      } else if (event.keyCode == KeyCode.ESC) {
        _host.value = _oldValue;
      }
    }
  }

  void _send() {
    _valChanged.add(int.tryParse(_host.value) ?? 0);
  }
}

@Directive(
  selector: '[tjTextArea]',
)
class TextAreaBinder {
  final TextAreaElement _host;

  final _valChanged = StreamController<String>();

  TextAreaBinder(Element el) : _host = el;

  @Input()
  set bind(value) {
    _host.value = value?.toString() ?? '';
  }

  @Output()
  Stream<String> get bind => _valChanged.stream;

  String _oldValue;

  @HostListener('focus')
  void onFocus(_) {
    _oldValue = _host.value;
  }

  @HostListener('blur')
  void onBlur(_) {
    _valChanged.add(_host.value);
  }

  @HostListener('keyup')
  void onKeyUp(KeyboardEvent event) {
    if (event.keyCode == KeyCode.ENTER && event.shiftKey) {
      _valChanged.add(_host.value);
    } else if (event.keyCode == KeyCode.ESC) {
      _host.value = _oldValue;
    }
  }
}

@Directive(selector: 'select[tjSelect]')
class SelectBoxBinder {
  final SelectElement _host;

  SelectBoxBinder(Element el) : _host = el;

  final _valChanged = StreamController<String>();

  @Output()
  Stream<String> get bind => _valChanged.stream;

  @Input()
  set bind(value) {
    _host.value = value;
  }

  @HostListener('change')
  void onChange(value) {
    _valChanged.add(_host.value);
  }
}
