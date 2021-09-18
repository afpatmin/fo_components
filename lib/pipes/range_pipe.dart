import 'package:angular/angular.dart';

@Pipe('range')
class RangePipe {
  Iterable<Object> transform(Iterable<Object> value, int from, int to) {
    final output = <Object>[];
    for (var i = from; i < to; i++) {
      if (i >= value.length) break;
      output.add(value.elementAt(i));
    }
    return output;
  }
}
