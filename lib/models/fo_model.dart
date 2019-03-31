@Deprecated('This will be removed completely in a future release')
class FoModel {
  FoModel();

  Map<String, dynamic> toJson() => {'id': id.toString()};

  @override
  String toString() => id.toString();

  Object id;
}
