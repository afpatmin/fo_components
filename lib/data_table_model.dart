abstract class DataTableModel
{
  DataTableModel(this._id);

  Map<String, String> toTableRow();

  String get id => _id;
  final String _id;

 // String toString() => id;
}