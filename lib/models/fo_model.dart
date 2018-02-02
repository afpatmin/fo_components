import 'dart:convert' show JSON;

abstract class FoModel
{
  /// Default constructor
  FoModel(this.id);

  /// Construct a model and populate its members from a map
  // ignore: avoid_unused_constructor_parameters
  FoModel.fromMap(Map<String, Object> map);

  /// Exposes capability to get model value like model[key]
  dynamic operator[](Object key)
  {
    switch (key)
    {
      case 'id': return id;
      default: return null;
    }
  }

  /// Exposes model[key] = value capability for the model
  void operator []=(Object key, covariant Object value)
  {
    switch (key)
    {
      case 'id': id = value; break;
    }
  }

  /// Returns a map representation of the model
  Map<dynamic, dynamic> toMap() => {'id':id};

  @override
  String toString() => JSON.encode(toMap());

  /// The model id
  String id;
}