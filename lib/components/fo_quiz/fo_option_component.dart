import 'dart:async';

import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_button/fo_button_component.dart';

import '../../models/fo_quiz_model.dart';

@Component(
  selector: 'fo-option',
  templateUrl: 'fo_option_component.html',
  styleUrls: ['fo_option_component.css'],
  directives: [FoButtonComponent, NgIf],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoOptionComponent implements OnDestroy {
  final StreamController<FoOptionModel> _triggerController = StreamController();

  @Input()
  FoOptionModel? model;

  @Input()
  bool disabled = false;

  @Input()
  String? buttonColor;

  @Output('trigger')
  Stream<FoOptionModel> get onTrigger => _triggerController.stream;

  @override
  void ngOnDestroy() {
    _triggerController.close();
  }

  void onSelect() {
    if (model != null) {
      _triggerController.add(model!.copyWith(selected: model!.selected));
    }
  }
}
