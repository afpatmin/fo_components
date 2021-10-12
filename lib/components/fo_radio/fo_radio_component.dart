import 'dart:async';

import 'package:angular/angular.dart';

import '../../src/components/fo_label/fo_label_component.dart';

@Component(
  selector: 'fo-radio',
  templateUrl: 'fo_radio_component.html',
  styleUrls: ['fo_radio_component.css'],
  directives: [coreDirectives, FoLabelComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoRadioComponent implements OnDestroy {
  final StreamController<Object?> _checkedController =
      StreamController<Object?>();

  @Input()
  Object? value;

  @Input()
  String label = '';

  @Input()
  bool checked = false;

  @Input()
  bool disabled = false;

  void onChange() {
    if (disabled || checked) {
      return;
    }
    checked = true;
    _checkedController.add(value);
  }

  Stream<Object?> get checkedChange => _checkedController.stream;

  @override
  void ngOnDestroy() {
    _checkedController.close();
  }
}
