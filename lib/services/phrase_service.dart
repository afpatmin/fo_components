import 'dart:async' show Future;
import 'package:angular/di.dart';

@Injectable()
class PhraseService
{
  PhraseService();

  static void set data(Map<String, Map<String, String>> value)
  {
    _data = value;

    /// Fake server fetch
    _loading = true;
    new Future.delayed(const Duration(milliseconds: 200)).then((_) => _loading = false);
  }

  static void set language(String value)
  {
    _language = value;

    /// Fake server fetch
    _loading = true;
    new Future.delayed(const Duration(milliseconds: 200)).then((_) => _loading = false);
  }

  String get(String key, {Map<String, String> params : null, bool capitalize_first : true})
  {
    if (key == null) return null;
    else if (key.isEmpty) return "";
    else if (!_data.containsKey(_language)) return key;
    else
    {
      String phrase = (_data[_language].containsKey(key)) ? _data[_language][key] : key;
      if (capitalize_first && !phrase.isEmpty) phrase = phrase[0].toUpperCase() + phrase.substring(1, phrase.length);

      if (params != null)
      {
        params.forEach((key, value)
        {
          if (value != null) phrase = phrase.replaceAll("%$key%", value);
        });
      }
      return phrase;
    }
  }

  bool get loading => _loading;

  static bool _loading = false;
  static String _language = "en";
  static Map<String, Map<String, String>> _data = new Map();
}