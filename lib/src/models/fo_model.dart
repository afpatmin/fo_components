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

  List<String> get tableColumns => [];

  String getProperty(String property) => (data.containsKey(property)) ? data[property].toString() : null;

  static PhraseService ps = new PhraseService();

  String id;
  String label;
  Map<String, dynamic> data;


  @override
  String toString() => label == null ? id : ps.get(label);
}