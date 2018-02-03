abstract class FoModel
{
  /// Exposes capability to get model value like model[key]
  dynamic operator[](String key) => toJson()[key];

  Map<String, dynamic> toJson();

  /// The model id
  String id;

  @override
  String toString() => id;
}