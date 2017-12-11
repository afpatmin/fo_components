import 'dart:convert' show JSON;

abstract class FoModel
{
  FoModel.fromMap(Map<dynamic, dynamic> map);

  dynamic operator[](Object key)
  {
    switch (key)
    {
      case "id": return id;
      default: return null;
    }
  }

  operator []=(Object key, dynamic value)
  {
    switch (key)
    {
      case "id": id = value; break;
    }
  }

  Map<dynamic, dynamic> toMap() => {"id":id};

  @override
  String toString() => JSON.encode(toMap());

  String id;
}