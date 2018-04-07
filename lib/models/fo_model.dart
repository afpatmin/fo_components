abstract class FoModel
{
  Map<String, dynamic> toJson();

  Object id;

  @override
  String toString() => id;
}