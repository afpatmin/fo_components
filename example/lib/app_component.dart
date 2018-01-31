import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/fo_components.dart';
import 'service/model_service.dart';
import 'model/simple_model.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:vi_auth_client/vi_auth_client.dart';

@Component(
  selector: 'fo-demo-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const
  [
    materialDirectives,
    DataTableComponent,
    FoDateInputComponent,
    FoLoginComponent,
    FoModalComponent,
    FoMultiSelectComponent,
    FoNumberInputComponent,
    formDirectives,
    FoTimeInputComponent],
  providers: const [materialProviders, PhraseService, ModelService],
)
class AppComponent
{
  AppComponent(this.modelService)
  {
    date = new DateTime(date.year, date.month, date.day);
  }

  final ModelService modelService;


  DateTime date = new DateTime.now();

  String time = "22:30";
  double number = null;

  final Map<String, EvaluateColumnFn> evaluatedColumns =
  {
    "test": (FoModel model) => "HEJAAA!"
  };

  final List<SimpleModel> batchOperations =
  [
    new SimpleModel("delete", "delete"),
    new SimpleModel("test", "test"),
    new SimpleModel("test2", "test2")
  ];



  ViAuthClient authClient = new ViAuthClient("", "");



}
