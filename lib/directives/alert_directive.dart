
/// NOT USED
library attribute_directives.alert_directive;

import 'package:angular2/core.dart';

@Directive(selector:'[foAlert]')
class AlertDirective
{
  AlertDirective(this._ref)
  {
    print(_ref.nativeElement.id);
  }
/*

  @Input('foAlert')
  String foAlert;
*/

  final ElementRef _ref;
}