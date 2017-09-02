class FoModel
{
  FoModel(this.id);

  @override
  operator == (dynamic other)
  {
    if (!(other is FoModel)) return false;
    return hashCode.compareTo(other.hashCode) == 0;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, String> toTableRow() => {"id":id};

  String id;

//  bool selected = false;

  @override
  String toString() => id;
}