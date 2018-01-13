import 'fo_model.dart';

class OptionModel extends FoModel
{
  OptionModel(String id, this.label) : super(id);
  String toString() => label;
  final String label;
}