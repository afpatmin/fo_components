import 'package:angular/di.dart' show Pipe, PipeTransform;
import 'package:fo_components/fo_components.dart';

@Pipe("sort")
class SortPipe implements PipeTransform
{
  Iterable<String> transform(Iterable<String> keys, Map<String, FoModel> table, String column, String order)
  {
    if (column == null || column.isEmpty || order == null || order.isEmpty) return keys;

    List<FoModel> values = table.keys.where(keys.contains).map((key) => table[key]).toList(growable: false);
    values.sort((FoModel a, FoModel b) => sort(a.toTableRow(), b.toTableRow(), column, order));
    return values.map((value) => table.keys.firstWhere((key) => table[key] == value));
  }

  int sort(Map<String, String> a, Map<String, String> b, String column, String order)
  {
    if (a[column] == null) a[column] = "-";
    if (b[column] == null) b[column] = "-";

    try
    {
      // Number comparison
      num numA = num.parse(a[column]);
      num numB = num.parse(b[column]);
      return (order == "ASC") ? (numA - numB).toInt() : (numB - numA).toInt();
    }
    on FormatException
    {
      try
      {
        // Date comparison
        DateTime dateA = DateTime.parse(a[column]);
        DateTime dateB = DateTime.parse(b[column]);
        return (order == "ASC") ? (dateA.difference(dateB)).inMinutes : (dateB.difference(dateA)).inMinutes;
      }
      on FormatException
      {
        // Default String comparison
        String colA = a[column].toString().toLowerCase();
        String colB = b[column].toString().toLowerCase();

        return (order == "ASC") ? colA.compareTo(colB) : colB.compareTo(colA);
      }
    }
  }
}