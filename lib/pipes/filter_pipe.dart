import 'package:angular2/di.dart' show Pipe, PipeTransform;
import 'package:fo_components/fo_components.dart' show DataTableModel;

@Pipe("filter")
class FilterPipe implements PipeTransform
{
  List<String> transform(List<String> keys, Map<String, DataTableModel> data, String search_phrase)
  {
    if (search_phrase == null || search_phrase.isEmpty) return data.keys.toList(growable: false);
    else
    {
      List<String> keywordList = search_phrase.split(" ");
      return data.keys.where((key) => _find(keywordList, data[key])).toList(growable: false);
    }
  }

  bool _find(List<String> needles, DataTableModel model)
  {
    for (String needle in needles.where((v) => v.isNotEmpty && v != ""))
    {
      if (model.toTableRow().values.where((v) => v.toLowerCase().contains(needle.toLowerCase())).isNotEmpty) return true;
    }
    return false;
  }
}