library attribute_directives.lowercase_directive;

import 'dart:async';
import 'dart:html' as html;
import 'package:angular2/angular2.dart';

@Directive(selector: '[foLowercase]')
class LowercaseDirective implements OnInit
{
  LowercaseDirective(this._er);

  void ngOnInit()
  {
    html.Element nativeElement = _er.nativeElement;
    _input = nativeElement.querySelector("input");
  }

  @HostListener('keyup', const ['\$event'])
  void onInput(html.KeyboardEvent e)
  {
    if (_skipCodes.contains(e.keyCode)) return;
    new Timer(const Duration(milliseconds: 50), ()
    {
      _input.value = _input.value.toLowerCase();
      _input.dispatchEvent(new html.Event("input"));
    });
  }

  @HostListener('blur')
  void onBlur()
  {
    _input.value = _input.value.toLowerCase();
    _input.dispatchEvent(new html.Event("input"));
  }


  final List<int> _skipCodes =
  [
    html.KeyCode.SHIFT,
    html.KeyCode.CTRL,
    html.KeyCode.HOME,
    html.KeyCode.END,
    html.KeyCode.LEFT,
    html.KeyCode.RIGHT,
    html.KeyCode.TAB,
    html.KeyCode.BACKSPACE,
    html.KeyCode.DELETE
  ];

  final ElementRef _er;
  html.InputElement _input;


}