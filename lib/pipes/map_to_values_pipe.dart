import 'package:angular2/core.dart';

@Pipe(name: 'mapToValues')
class MapToValuesPipe implements PipeTransform
{
  List<dynamic> transform(Map<dynamic, dynamic> value) => value.values.toList(growable: false);
}