library attribute_directives.uppercase_directive;

import 'dart:html' as html;
import 'package:angular2/core.dart';

@Directive(selector: '[foUppercase]')
class UppercaseDirective implements OnInit
{
  UppercaseDirective(this._er);

  void ngOnInit()
  {
    html.Element nativeElement = _er.nativeElement;
    _input = nativeElement.querySelector("input");
  }

  @HostListener('input')
  void onInput()
  {
    _input.value = _input.value.toUpperCase();
  }

  final ElementRef _er;
  html.InputElement _input;


}