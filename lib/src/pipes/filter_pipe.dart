import 'package:angular/di.dart' show Pipe, PipeTransform;
import 'package:fo_components/fo_components.dart';

@Pipe("filter")
class FilterPipe implements PipeTransform
{
  Iterable<String> transform(Iterable<String> keys, Map<String, FoModel> table, String search_phrase)
  {
    if (search_phrase == null || search_phrase.isEmpty) return keys;

    List<String> keywords = search_phrase.split(" ");
    return table.values.where((model) => find(model, keywords)).map((value) => table.keys.firstWhere((key) => table[key] == value));
  }

  bool find(FoModel model, List<String> keywords)
  {
    return (model.toTableRow().values.firstWhere((value) => (keywords.firstWhere((keyword) =>
        value.toString().contains(keyword), orElse: () => null) != null), orElse: () => null) != null);
  }
}