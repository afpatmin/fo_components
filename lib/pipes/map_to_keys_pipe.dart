import 'package:angular2/core.dart';

@Pipe(name: 'mapToKeys')
class MapToKeysPipe implements PipeTransform
{
  List<dynamic> transform(Map<dynamic, dynamic> value) => value.keys.toList(growable: false);
}