import 'package:angular/di.dart' show Pipe, PipeTransform;

@Pipe('name')
class NamePipe implements PipeTransform {
  String transform(String value) =>
      value == null || value.isEmpty ? value : '${value[0].toUpperCase()}${value.substring(1)}';
}
