import 'package:fo_components/fo_components.dart';

class SimpleModel extends FoModel
{
  SimpleModel(String id, this.label) : super(id);

  final String label;


  String toString() => label;
}