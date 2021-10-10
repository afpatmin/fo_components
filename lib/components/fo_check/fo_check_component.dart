import 'dart:async';

import 'package:angular/angular.dart';

import '../../src/components/fo_label/fo_label_component.dart';

@Component(
  selector: 'fo-check',
  templateUrl: 'fo_check_component.html',
  styleUrls: ['fo_check_component.css'],
  directives: [
    coreDirectives,
    FoLabelComponent,
  ],
  providers: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoCheckComponent implements OnDestroy {
  final StreamController<bool> _checkedController = StreamController<bool>();

  FoCheckComponent();

  @Input()
  String label = '';

  @Input()
  bool checked = false;

  @Input()
  bool disabled = false;

  void onChange() {
    if (disabled) {
      return;
    }
    checked = !checked;
    _checkedController.add(checked);
  }

  @Output('checkedChange')
  Stream<bool> get checkedChange => _checkedController.stream;

  @override
  void ngOnDestroy() {
    _checkedController.close();
  }
}
