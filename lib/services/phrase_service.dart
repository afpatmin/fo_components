import 'dart:async' show Future;
import 'package:angular/di.dart';

@Injectable()
class PhraseService {
  PhraseService();

  // ignore: avoid_setters_without_getters
  static set data(Object value) {
    _data = value;

    /// Fake server fetch
    _loading = true;
    new Future.delayed(const Duration(milliseconds: 200))
        .then((_) => _loading = false);
  }

  static set language(String value) {
    _language = value;

    /// Fake server fetch
    _loading = true;
    new Future.delayed(const Duration(milliseconds: 200))
        .then((_) => _loading = false);
  }

  static String get language => _language;

  String get(String key,
      {Map<String, String> params, bool capitalizeFirst: true}) {
    if (key == null)
      return null;
    else if (key.isEmpty)
      return '';
    else if (!_data.containsKey(key))
      return key;
    else if (!_data[key].containsKey(_language))
      return key;
    else {
      var phrase = _data[key][_language];
      if (capitalizeFirst && phrase.isNotEmpty)
        phrase = phrase[0].toUpperCase() + phrase.substring(1, phrase.length);

      if (params != null) {
        params.forEach((key, value) {
          if (value != null) phrase = phrase.replaceAll('%$key%', value);
        });
      }
      return phrase;
    }
  }

  bool get loading => _loading;

  static bool _loading = false;
  static String _language = 'en';
  static var _data = {};
}
