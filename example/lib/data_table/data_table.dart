import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_data_table/fo_data_table_component.dart';
import 'package:fo_components/models/fo_model.dart';
import 'package:intl/intl.dart';
import '../component_info/component_info.dart';
import '../section/section.dart';

final DateFormat df = DateFormat('y');

@Component(
    selector: 'data-table',
    templateUrl: 'data_table.html',
    directives: [ComponentInfo, FoDataTableComponent, Section])
class DataTable {
  final String htmlDefault = '''  
<fo-data-table [data]="data"
               [columns]="columns"
               (rowclick)="clickedId = \$event">
</fo-data-table>
<p>Clicked country: {{clickedId}}</p>''';

  final String dartDefault = '''
Component {
  ... Component code ...  

  final columns = {
    'id': 'ID',
    'country': 'Country',
    'language': 'Language',
    'pop': 'Population',
    'founded': 'Founded'
  };

  final data = {
    'SE': DataModel()
      ..id = 'SE'
      ..founded = DateTime(1397, 01, 01)
      ..country = 'Sweden'
      ..language = 'Swedish'
      ..pop = 10000000,
    'DK': DataModel()
      ..id = 'DK'
      ..founded = DateTime(1397, 01, 01)
      ..country = 'Denmark'
      ..language = 'Danish'
      ..pop = 5750000,
    'NO': DataModel()
      ..id = 'NO'
      ..founded = DateTime(872, 01, 01)
      ..country = 'Norway'
      ..language = 'Norwegian'
      ..pop = 5300000,
    'FI': DataModel()
      ..id = 'FI'
      ..founded = DateTime(1809, 03, 29)
      ..country = 'Finland'
      ..language = 'Finnish'
      ..pop = 5503000,
    'ISL': DataModel()
      ..id = 'ISL'
      ..founded = DateTime(1944, 06, 17)
      ..country = 'Iceland'
      ..language = 'Icelandic'
      ..pop = 339000,
    'BE': DataModel()
      ..id = 'BE'
      ..founded = DateTime(1830, 10, 4)
      ..country = 'Belgium'
      ..language = 'Dutch, French, German'
      ..pop = 11350000,
    'FR': DataModel()
      ..id = 'FR'
      ..founded = DateTime(1789, 07, 14)
      ..country = 'France'
      ..language = 'French'
      ..pop = 67190000,
  };
}

class DataModel extends FoModel {
  DateTime founded;
  String country;
  String language;
  int pop;

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'country': country,
    'language': language,
    'pop': pop,
    'founded': df.format(founded)
  };
}
''';

  final Map<String, String> columns = {
    'id': 'ID',
    'country': 'Country',
    'language': 'Language',
    'pop': 'Population',
    'founded': 'Founded'
  };

  final Map<String, DataModel> data = {
    'SE': DataModel()
      ..id = 'SE'
      ..founded = DateTime(1397, 01, 01)
      ..country = 'Sweden'
      ..language = 'Swedish'
      ..pop = 10000000,
    'DK': DataModel()
      ..id = 'DK'
      ..founded = DateTime(1397, 01, 01)
      ..country = 'Denmark'
      ..language = 'Danish'
      ..pop = 5750000,
    'NO': DataModel()
      ..id = 'NO'
      ..founded = DateTime(872, 01, 01)
      ..country = 'Norway'
      ..language = 'Norwegian'
      ..pop = 5300000,
    'FI': DataModel()
      ..id = 'FI'
      ..founded = DateTime(1809, 03, 29)
      ..country = 'Finland'
      ..language = 'Finnish'
      ..pop = 5503000,
    'ISL': DataModel()
      ..id = 'ISL'
      ..founded = DateTime(1944, 06, 17)
      ..country = 'Iceland'
      ..language = 'Icelandic'
      ..pop = 339000,
    'BE': DataModel()
      ..id = 'BE'
      ..founded = DateTime(1830, 10, 4)
      ..country = 'Belgium'
      ..language = 'Dutch, French, German'
      ..pop = 11350000,
    'FR': DataModel()
      ..id = 'FR'
      ..founded = DateTime(1789, 07, 14)
      ..country = 'France'
      ..language = 'French'
      ..pop = 67190000,
  };

  String clickedId;
}

class DataModel extends FoModel {
  DateTime founded;
  String country;
  String language;
  int pop;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'country': country,
        'language': language,
        'pop': pop,
        'founded': df.format(founded)
      };
}
