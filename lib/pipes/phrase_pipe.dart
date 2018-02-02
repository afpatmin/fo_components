import 'package:angular/di.dart' show Pipe, PipeTransform;
import 'package:fo_components/fo_components.dart';

@Pipe('phrase')
class PhrasePipe implements PipeTransform
{
  PhrasePipe(this._phraseService);

  String transform(String value, [bool capitalizeFirst = true])
  {
    if (value == null) return null;
    return _phraseService.get(value, capitalizeFirst: capitalizeFirst);
  }

  final PhraseService _phraseService;
}