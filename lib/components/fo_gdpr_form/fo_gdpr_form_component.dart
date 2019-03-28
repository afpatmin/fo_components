import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_checkbox/material_checkbox.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fo_model/fo_model.dart';
import '../../services/fo_messages_service.dart';
import '../../validators/fo_validators.dart';
import '../fo_modal/fo_modal_component.dart';
import '../fo_select/fo_select_component.dart';

@Component(
    selector: 'fo-gdpr-form',
    templateUrl: 'fo_gdpr_form_component.html',
    styleUrls: [
      'fo_gdpr_form_component.css'
    ],
    directives: [
      FoModalComponent,
      formDirectives,
      FoSelectComponent,
      MaterialButtonComponent,
      MaterialCheckboxComponent,
      materialInputDirectives,
      NgIf
    ],
    pipes: [])
class FoGdprFormComponent implements OnDestroy {
  FoGdprFormComponent(this.msg)
      : form = ControlGroup({
          'firstname': Control()
            ..validator = Validators.compose(
                [Validators.required, Validators.maxLength(50)]),
          'lastname': Control()
            ..validator = Validators.compose(
                [Validators.required, Validators.maxLength(50)]),
          'phone': Control()
            ..validator = Validators.compose([
              Validators.required,
              FoValidators.phoneNumber,
              Validators.maxLength(15)
            ]),
          'email': new Control()
            ..validator = Validators.compose([
              Validators.required,
              FoValidators.email,
              Validators.maxLength(128)
            ]),
          'comments': new Control()
            ..validator = Validators.compose([Validators.maxLength(1000)])
        }),
        options = [
          FoModel()..id = msg.gdpr_fetch_my_info(),
          FoModel()..id = msg.gdpr_fetch_my_info_portable(),
          FoModel()..id = msg.gdpr_change_my_info(),
          FoModel()..id = msg.gdpr_limit_my_data_processing(),
          FoModel()..id = msg.gdpr_oppose_my_data_processing(),
          FoModel()..id = msg.gdpr_erase_me()
        ];

  @override
  void ngOnDestroy() {
    openController.close();
  }

  void submit() {
    _submitController.add(model);
    sent = true;
  }

  final ControlGroup form;

  bool termsChecked = false;
  bool sent = false;
  final GdprModel model = new GdprModel();

  final List<FoModel> options;

  final StreamController<bool> openController = new StreamController();
  final StreamController<GdprModel> _submitController = new StreamController();
  final FoMessagesService msg;

  @Input()
  bool open = false;

  @Input()
  String readMoreLink;

  @Output('openChange')
  Stream<bool> get openChange => openController.stream;

  @Output('submit')
  Stream<GdprModel> get onSubmit => _submitController.stream;
}

class GdprModel {
  String firstname;
  String lastname;
  String phone;
  String email;
  String comments;
  String selected_issue = 'gdpr_fetch_my_info';

  Map<String, String> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'email': email,
        'comments': comments,
        'selected_issue': selected_issue
      };
}
