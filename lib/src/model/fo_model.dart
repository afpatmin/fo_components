import 'dart:convert' show JSON;

abstract class FoModel
{
  FoModel.fromMap(Map<dynamic, dynamic> map);

  dynamic operator[](Object key)
  {
    switch (key)
    {
      case "id": return id;
      case "created": return created;
      case "added_by" : return added_by;
      case "status": return status;
      default: return null;
    }
  }

  operator []=(Object key, dynamic value)
  {
    switch (key)
    {
      case "id": id = value; break;
      case "created": created = value; break;
      case "added_by" : added_by = value; break;
      case "status": status = value; break;
    }
  }

  Map<dynamic, dynamic> toMap() => {"id":id, "created":created, "added_by":added_by, "status":status};

  @override
  String toString() => JSON.encode(toMap());

  String id;
  DateTime created;
  String added_by;
  String status = "active"; // active, frozen, disabled
}