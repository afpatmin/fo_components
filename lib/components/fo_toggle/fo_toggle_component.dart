import 'dart:async';

import 'package:angular/angular.dart';

import '../../src/components/fo_label/fo_label_component.dart';

@Component(
  selector: 'fo-toggle',
  templateUrl: 'fo_toggle_component.html',
  styleUrls: ['fo_toggle_component.css'],
  directives: [coreDirectives, FoLabelComponent],
  providers: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoToggleComponent implements OnDestroy {
  final StreamController<bool> _checkedController = StreamController<bool>();

  @Input()
  String label = '';

  @Input()
  bool checked = false;

  @Input()
  bool disabled = false;

  @Output('checkedChange')
  Stream<bool> get checkedChange => _checkedController.stream;

  @override
  void ngOnDestroy() {
    _checkedController.close();
  }

  void onChange() {
    if (disabled) {
      return;
    }
    checked = !checked;
    _checkedController.add(checked);
  }
}
