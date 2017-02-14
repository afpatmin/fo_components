library fo_filtering;
import 'dart:collection' show SplayTreeMap;


class FoFiltering
{
  static Map<String, Map<String, String>> filter(Map<String, Map<String, String>> source, String keywords)
  {
    if (keywords.isEmpty) return new Map.from(source);

    Map<String, Map<String, String>> filtered = new Map();
    List<String> keywordList = keywords.split(" ");

    source.forEach((String key, Map<String, String> row)
    {
      int matchCount = 0;
      for (String keyword in keywordList)
      {
        if (row.values.where((value) => matchKeyword(value.toLowerCase(), keyword.toLowerCase())).isNotEmpty) matchCount++;
      }
      if (matchCount == keywordList.length) filtered[key] = row;
    });
    return filtered;
  }

  static bool matchKeyword(String value, String keyword)
  {
    return (keyword.isEmpty || value.contains(keyword));
  }

  static Map<String, Map<String, String>> sort(Map<String, Map<String, String>> source, String column, String sort_order)
  {
    return new Map.from(new SplayTreeMap.from(source, (key1, key2) => _compareColumn(source, key1, key2, column, sort_order)));
  }

  static int _compareColumn(Map<String, Map<String, String>> source, String key1, String key2, String column, String sort_order)
  {
    int value = _compare(source[key1][column], source[key2][column], sort_order);
    if (value == 0) value = 1; // columns can have multiple values with the same value
    return value;
  }

  static int _compare(String key1, String key2, String sort_order)
  {
    num num1, num2;
    try
    {
      num1 = num.parse(key1);
      num2 = num.parse(key2);
    } on FormatException
    {
      // NaN, compare strings
      if (sort_order == "ASC") return key1.compareTo(key2);
      else return key2.compareTo(key1);
    }
    return (sort_order == "ASC") ? num1 - num2 : num2 - num1;
  }
}