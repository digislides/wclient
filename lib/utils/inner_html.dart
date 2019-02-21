import 'dart:html';

class MyNodeValidator implements NodeValidator {
  bool allowsElement(Element element) => true;

  bool allowsAttribute(Element element, String attributeName, String value) =>
      true;
}