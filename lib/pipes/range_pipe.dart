import 'package:angular2/core.dart';

@Pipe('range')
class RangePipe implements PipeTransform
{
  Iterable<String> transform(Iterable<String> value, int from, int to)
  {
    List<String> filtered = new List();
    for (int i = from; i < to; i++)
    {
      if (i >= value.length) break;
      filtered.add(value.elementAt(i));
    }
    return filtered;
  }
}