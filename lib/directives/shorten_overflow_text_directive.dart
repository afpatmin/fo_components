library attribute_directives.shorten_overflow_text;

import 'dart:html' as html;
import 'dart:math';
import 'package:angular2/angular2.dart';

@Directive(selector: '[foShortenOverflow]')
class ShortenOverflowTextDirective implements OnChanges, AfterViewChecked
{
  ShortenOverflowTextDirective(ElementRef element_ref)
      : _element = element_ref.nativeElement, _parentElement = element_ref.nativeElement.parent
  {
    html.window.onResize.listen((_) => _adjustTextLength());
  }

  void ngAfterViewChecked()
  {
    _adjustTextLength();
  }

  void ngOnChanges(Map<String, SimpleChange> data)
  {
    //fullText = data["text"].currentValue;
    _adjustTextLength();
  }

  /*
  void ngAfterContentChecked()
  {
    _adjustTextLength();
  }
  */

  void _adjustTextLength()
  {
    if (fullText == null || fullText.isEmpty) return;

    String croppedValue = fullText;

    _element.text = croppedValue;
    html.Rectangle<double> parentRect = _parentElement.getBoundingClientRect();
    html.Rectangle<double> rect = _element.getBoundingClientRect();
    double parentWidth = parentRect.right - parentRect.left;
    double width = rect.right - rect.left;

    if (width == 0) return;

    double dotMargin = 20.0;
    int overflowGuard = 999;

    while (width + dotMargin > parentWidth && croppedValue.isNotEmpty && overflowGuard > 0)
    {
      croppedValue = croppedValue.substring(0, max(croppedValue.length - 1, 0));
      _element.text = croppedValue;
      rect = _element.getBoundingClientRect();
      width = rect.right - rect.left;
      overflowGuard--;
    }

    _element.text = (overflowGuard < 999) ? croppedValue + "..." : croppedValue;
  }

  @Input('foShortenOverflow')
  String fullText = "";

  final html.Element _element;
  final html.Element _parentElement;
}