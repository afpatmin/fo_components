import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_dropdown_select/fo_dropdown_select_component.dart';
import 'package:fo_components/components/fo_dropdown_list/fo_dropdown_option.dart';
import '../component_info/component_info.dart';
import '../section/section.dart';

@Component(
    selector: 'dropdown-select',
    templateUrl: 'dropdown_select.html',
    directives: [ComponentInfo, FoDropdownSelectComponent, Section])
class DropdownSelect {
  final String htmlDefault = '''  
<fo-dropdown-select label="Select object"
                    [options]="options"
                    [(selectedId)]="selectedId">
</fo-dropdown-select>
<p>Selected id: {{selectedId}}</p>''';

  final String dartDefault = '''
final Map<String, List<FoDropdownOption>> options = {
  'category #1': [
    FoDropdownOption()
      ..id = 'id1'
      ..value = 'value1'
      ..info = 'info1'
      ..label = 'label1'
      ..icon = 'delete',
    FoDropdownOption()
      ..id = 'id2'
      ..value = 'value2'
      ..info = 'info2'
      ..label = 'label2'
      ..icon = 'keyboard_arrow_up'
  ]
};
''';

  final Map<String, List<FoDropdownOption>> options = {
    'category #1': [
      FoDropdownOption()
        ..id = 'id1'
        ..value = 'value1'
        ..info = 'info1'
        ..label = 'label1'
        ..icon = 'delete',
      FoDropdownOption()
        ..id = 'id2'
        ..value = 'value2'
        ..info = 'info2'
        ..label = 'label2'
        ..icon = 'keyboard_arrow_up'
    ]
  };

  String selectedId;
}
