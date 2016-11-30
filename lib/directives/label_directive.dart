
///
///
/// NOT USED
library attribute_directives.label_directive;

import 'package:angular2/core.dart';

@Directive(selector:'[foLabel]')
class LabelDirective
{
  LabelDirective(ElementRef element)
  {
    element.nativeElement.setInnerHtml('DYNAMIC LABEL');
  }
}