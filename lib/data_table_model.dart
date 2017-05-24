abstract class DataTableModel
{
  DataTableModel(this.id);

  Map<String, String> toTableRow();

  String id;

  @override
  String toString() => id;
}