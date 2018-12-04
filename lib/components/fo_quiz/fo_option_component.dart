import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import '../../models/fo_quiz_model.dart';

@Component(
  selector: 'fo-option',
  templateUrl: 'fo_option_component.html',
  styleUrls: const ['fo_option_component.css'],
  directives: const [NgIf, MaterialButtonComponent],
  changeDetection: ChangeDetectionStrategy.OnPush
)
class FoOptionComponent implements OnDestroy {

  @override
  void ngOnDestroy() {
    _triggerController.close();
  }

  void onSelect() {
    model.selected = !model.selected;
    _triggerController.add(model);    
  }

  final StreamController<FoOptionModel> _triggerController = new StreamController();

  @Input()
  FoOptionModel model;

  @Input()
  bool disabled = false;

  @Input()
  String buttonColor;

  @Output('trigger')
  Stream<FoOptionModel> get onTrigger => _triggerController.stream;
}