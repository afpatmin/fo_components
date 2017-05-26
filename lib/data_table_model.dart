class DataTableModel
{
  DataTableModel(this.id);

  Map<String, String> toTableRow() => {"id":id};

  String id;

  @override
  String toString() => id;
}