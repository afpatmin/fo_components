import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fo_components/components/fo_text_input/fo_text_input_component.dart';
import 'package:fo_components/components/fo_dropdown_list/fo_dropdown_option.dart';
import 'package:fo_components/validators/fo_validators.dart';
import '../component_info/component_info.dart';
import '../section/section.dart';

@Component(
    selector: 'text-input',
    templateUrl: 'text_input.html',
    directives: [ComponentInfo, FoTextInputComponent, formDirectives, Section])
class TextInput {
  final String htmlDefault = '''  
<fo-text-input label="Enter a value"
               [(ngModel)]="textInputValue">
</fo-text-input>
<p>Text: {{textInputValue}}</p>''';

  final String htmlAutoSuggest = '''
<fo-text-input label="Enter your job title"
               [options]="autoSuggestOptions"
               [(ngModel)]="autoSuggest">
</fo-text-input>
<p>Text: {{autoSuggest}}</p>
''';

final String dartAutoSuggest = '''
import 'package:fo_components/components/fo_dropdown_list/fo_dropdown_option.dart';
...

final Map<String, List<FoDropdownOption>> autoSuggestOptions = {
  'Management': [
    FoDropdownOption()
      ..id = '1'
      ..label = 'Floor manager',
    FoDropdownOption()
      ..id = '2'
      ..label = 'Department manager',
    FoDropdownOption()
      ..id = '3'
      ..info = 'The big kahuna'
      ..label = 'CEO'
  ],
  'Floor staff': [
    FoDropdownOption()
      ..id = '4'
      ..label = 'Cashier'
      ..icon = 'face',
    FoDropdownOption()
      ..id = '5'
      ..label = 'Janitor'
      ..icon = 'vpn_key',
    FoDropdownOption()
      ..id = '6'
      ..label = 'Laundry staff'
      ..icon = 'local_laundry_service'
  ]
};
''';

  final String htmlValidation = '''
<form [ngFormModel]="form">
  <fo-text-input label="Your email"
                 [(ngModel)]="email"
                 ngControl="email">
  </fo-text-input>
  <p>Text: {{email}}</p>
</form>''';

  String autoSuggest;
  String text;
  String email;

  final Map<String, List<FoDropdownOption>> autoSuggestOptions = {
    'Management': [
      FoDropdownOption()
        ..id = '1'
        ..label = 'Floor manager',
      FoDropdownOption()
        ..id = '2'
        ..label = 'Department manager',
      FoDropdownOption()
        ..id = '3'
        ..info = 'The big kahuna'
        ..label = 'CEO'
    ],
    'Floor staff': [
      FoDropdownOption()
        ..id = '4'
        ..label = 'Cashier'
        ..icon = 'face',
      FoDropdownOption()
        ..id = '5'
        ..label = 'Janitor'
        ..icon = 'vpn_key',
      FoDropdownOption()
        ..id = '6'
        ..label = 'Laundry staff'
        ..icon = 'local_laundry_service'
    ]
  };

  final ControlGroup form = ControlGroup({
    'email': Control(
        '', Validators.compose([Validators.required, FoValidators.email]))
  });
}
