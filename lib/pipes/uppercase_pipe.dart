import 'package:angular2/core.dart';

@Pipe('uppercase')
class UppercasePipe implements PipeTransform
{
  String transform(String value) => value.toUpperCase();
}