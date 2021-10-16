import 'dart:html' as dom;

import 'package:angular/angular.dart';

@Directive(selector: '[reorderItem]')
class ReorderItemDirective {
  final dom.HtmlElement element;

  ReorderItemDirective(this.element);
}
