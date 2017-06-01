import 'dart:convert';
class DataTableModel
{
  DataTableModel(this.id);

  @override
  operator == (dynamic other)
  {
    if (!(other is DataTableModel)) return false;
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, String> toTableRow() => {"id":id};

  String id;

  @override
  String toString() => id;
}