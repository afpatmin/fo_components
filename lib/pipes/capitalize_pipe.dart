import 'package:angular/di.dart' show Pipe, PipeTransform;

/// Makes the first letter of a string uppercase
/// patrick --> Patrick
@Pipe('capitalize')
class CapitalizePipe implements PipeTransform {
  String transform(String value) => value == null || value.isEmpty
      ? value
      : '${value[0].toUpperCase()}${value.substring(1)}';
}
