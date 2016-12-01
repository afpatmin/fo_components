
library attribute_directives.form_directive;
import 'dart:html' as dom;
import 'package:angular2/core.dart';
import 'package:fo_components/directives/submit_button_directive.dart';
import 'package:fo_components/components/input_component.dart';

@Directive(selector:'[foForm]')
class FormDirective implements AfterContentInit
{
  FormDirective(ElementRef element) : _element = element.nativeElement;

  @ContentChild(SubmitButtonDirective)
  SubmitButtonDirective button;


  @ContentChildren(InputComponent)
  QueryList<InputComponent> inputs;



  @override
  void ngAfterContentInit()
  {



   // button.element.disabled = true;
  }


  @Output('foSubmit')
  EventEmitter foSubmit = new EventEmitter<String>();

  @Input('foForm')
  String color = "#abc";

  @HostListener('click')
  void onClick()
  {
    _element.style.backgroundColor = color;
  }
  final dom.FormElement _element;
}