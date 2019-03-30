import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_data_table/fo_data_table_component.dart';
import 'package:fo_model/fo_model.dart';
import '../component_info/component_info.dart';
import '../section/section.dart';

@Component(
    selector: 'data-table',
    templateUrl: 'data_table.html',
    directives: [ComponentInfo, FoDataTableComponent, Section])
class DataTable {
  final String htmlDefault = '''  
<p> CONTENT HERE </p>''';

  final columns = {
    'id': 'ID',
    'country': 'Country',
    'language': 'Language',
    'pop': 'Population'
  };

  final data = {
    '1': DataModel()
      ..id = '1'
      ..founded = DateTime(1100, 01, 12)
      ..country = 'Sweden'
      ..language = 'Swedish'
      ..pop = 10000000,
    '2': DataModel()
      ..id = '2'
      ..founded = DateTime(1200, 01, 12)
      ..country = 'Denmark'
      ..language = 'Danish'
      ..pop = 5000000,
    '3': DataModel()
      ..id = '3'
      ..founded = DateTime(1300, 01, 12)
      ..country = 'Norway'
      ..language = 'Norwegian'
      ..pop = 4000000,
    '4': DataModel()
      ..id = '1'
      ..founded = DateTime(1400, 01, 12)
      ..country = 'Finland'
      ..language = 'Finnish'
      ..pop = 4000000,
    '5': DataModel()
      ..id = '5'
      ..founded = DateTime(1500, 01, 12)
      ..country = 'Iceland'
      ..language = 'Icelandic'
      ..pop = 250000,
  };
}

class DataModel extends FoModel {
  DateTime founded;
  String country;
  String language;
  int pop;

  @override
  Map<String, dynamic> toJson() =>
      {'id': id, 'country': country, 'language': language, 'pop': pop};
}
