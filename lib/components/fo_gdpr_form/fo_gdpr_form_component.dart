import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fo_components/fo_components.dart';
import 'package:fo_model/fo_model.dart';

@Component(
    selector: 'fo-gdpr-form',
    templateUrl: 'fo_gdpr_form_component.html',
    styleUrls: [
      'fo_gdpr_form_component.css'
    ],
    directives: [
      coreDirectives,
      formDirectives,
      FoModalComponent,
      FoSelectComponent,
      materialDirectives
    ],
    providers: [],
    pipes: [
      PhrasePipe
    ])
class FoGdprFormComponent implements OnDestroy {
  FoGdprFormComponent();

  @override
  void ngOnDestroy() {
    openController.close();
  }

  void submit() {
    _submitController.add(model);
    sent = true;
  }

  final ControlGroup form = ControlGroup({
    'firstname': Control()
      ..validator = Validators.compose([
        FoValidators.required('enter_a_firstname'),
        Validators.maxLength(50)
      ]),
    'lastname': Control()
      ..validator = Validators.compose([
        FoValidators.required('enter_a_lastname'),
        Validators.maxLength(50)
      ]),
    'phone': Control()
      ..validator = Validators.compose([
        FoValidators.required('enter_a_phone'),
        FoValidators.phoneNumber,
        Validators.maxLength(15)
      ]),
    'email': new Control()
      ..validator = Validators.compose([
        FoValidators.required('enter_an_email'),
        FoValidators.email,
        Validators.maxLength(128)
      ]),
    'comments': new Control()
      ..validator = Validators.compose([Validators.maxLength(1000)])
  });

  bool termsChecked = false;
  bool sent = false;
  final GdprModel model = new GdprModel();

  final List<FoModel> options = [
    FoModel()..id = 'gdpr_fetch_my_info',
    FoModel()..id = 'gdpr_fetch_my_info_portable',
    FoModel()..id = 'gdpr_change_my_info',
    FoModel()..id = 'gdpr_limit_my_data_processing',
    FoModel()..id = 'gdpr_oppose_my_data_processing',
    FoModel()..id = 'gdpr_erase_me',
  ];

  final StreamController<bool> openController = new StreamController();
  final StreamController<GdprModel> _submitController = new StreamController();

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
