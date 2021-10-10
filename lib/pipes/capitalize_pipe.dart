import 'package:angular/angular.dart';

/// Makes the first letter of a string uppercase
/// patrick --> Patrick
@Pipe('capitalize')
class CapitalizePipe {
  String transform(String value) =>
      value.isEmpty ? value : '${value[0].toUpperCase()}${value.substring(1)}';

  bool supports(Object obj) => obj is String;
}
