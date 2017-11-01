import '../services/phrase_service.dart';

class FoModel
{
  FoModel(this.id, [this.label = null]);

  @override
  operator == (dynamic other)
  {
    if (!(other is FoModel)) return false;
    return hashCode.compareTo(other.hashCode) == 0;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, String> toTableRow() => label == null ? {"id":id} : {"id":id, "label":ps.get(label)};

  static PhraseService ps = new PhraseService();

  String id;
  String label;

  @override
  String toString() => label == null ? id : ps.get(label);
}