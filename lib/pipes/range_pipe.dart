import 'package:angular/di.dart' show Pipe, PipeTransform;

@Pipe('range')
class RangePipe implements PipeTransform
{
  Iterable<Object> transform(Iterable<Object> value, int from, int to)
  {
    final filtered = <Object>[];
    for (var i = from; i < to; i++)
    {
      if (i >= value.length) break;
      filtered.add(value.elementAt(i));
    }
    return filtered;
  }
}