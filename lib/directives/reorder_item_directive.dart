import 'dart:html' as dom;

import 'package:ngdart/angular.dart';

@Directive(selector: '[reorderItem]')
class ReorderItemDirective {
  final dom.HtmlElement element;

  ReorderItemDirective(this.element);
}
