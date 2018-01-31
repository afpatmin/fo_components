import 'package:fo_components/fo_components.dart';

class Model implements FoModel
{
  Model(this.id, this.name, this.email, this.phone, this.start, this.active);

  String name;
  String email;
  String phone;
  DateTime start;
  bool active;
  String nullValue;

  @override
  operator []=(Object key, dynamic value)
  {
    switch (key)
    {
      case "id": id = value; break;
      case "name": name = value; break;
      case "email": email = value; break;
      case "phone": phone = value; break;
      case "start": start = value; break;
      case "active": active = value; break;
      case "nullValue": nullValue = value; break;
      default: break;
    }
  }

  @override
  dynamic operator [](Object key)
  {
    switch (key)
    {
      case "id": return id;
      case "name": return name;
      case "email": return email;
      case "phone": return phone;
      case "start": return start;
      case "active": return active;
      case "nullValue": return nullValue;
      default: return null;
    }
  }

  @override
  String id;

  @override
  Map<dynamic, dynamic> toMap() => {"id":id, "name":name, "email":email, "phone":phone, "start":start, "active":active, "nullValue":nullValue};
}