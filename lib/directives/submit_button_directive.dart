
library attribute_directives.submit_button_directive;
import 'dart:html' as dom;
import 'package:angular2/core.dart';

@Directive(selector:'[foSubmit]')
class SubmitButtonDirective
{
  SubmitButtonDirective(ElementRef element) : _element = element.nativeElement;


  dom.ButtonElement get element => _element;


  @HostListener('submit')
  void _onSubmit()
  {
    //_foOnSubmit.add("test");

  }

  //final EventEmitter<String> _foOnSubmit = new EventEmitter();
  final dom.ButtonElement _element;
}