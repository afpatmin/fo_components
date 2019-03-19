import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'fo_button_event.dart';

@Component(
    selector: 'fo-button',
    templateUrl: 'fo_button_component.html',
    styleUrls: const ['fo_button_component.css'],
    directives: const [MaterialIconComponent, NgClass, NgIf],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoButtonComponent implements OnDestroy {
  @Input()
  String label;

  @Input()
  String icon;

  @Input()
  bool leftBorder = true;

  @Input()
  bool rightBorder = true;

  @Input()
  bool disabled = false;

  @Output('trigger')
  Stream<FoButtonEvent> get trigger => _triggerController.stream;

  void onClick() {
    if (disabled != true) {
      _triggerController.add(FoButtonEvent());
    }
  }

  final StreamController _triggerController = StreamController<FoButtonEvent>();

  FoButtonComponent();

  @override
  void ngOnDestroy() {
    _triggerController.close();
  }
}
