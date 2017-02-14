import 'package:angular2/core.dart';

@Pipe(name: 'uppercase')
class UppercasePipe implements PipeTransform
{
  String transform(String value) => value.toUpperCase();
}