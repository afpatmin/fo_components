library attribute_directives.lowercase_directive;

import 'dart:html' as html;
import 'package:angular2/core.dart';

@Directive(selector: '[foLowercase]')
class LowercaseDirective implements OnInit
{
  LowercaseDirective(this._er);

  void ngOnInit()
  {
    html.Element nativeElement = _er.nativeElement;
    _input = nativeElement.querySelector("input");
  }

  @HostListener('input')
  void onInput()
  {
    _input.value = _input.value.toLowerCase();
  }

  final ElementRef _er;
  html.InputElement _input;


}