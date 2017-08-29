//import 'package:angular_components/angular_components.dart' show Filterable;

class DataTableModel
{
  DataTableModel(this.id);

  @override
  operator == (dynamic other)
  {
    if (!(other is DataTableModel)) return false;
    return hashCode.compareTo(other.hashCode) == 0;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, String> toTableRow() => {"id":id};

  String id;

  @override
  String toString() => id;
}