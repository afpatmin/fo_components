import 'dart:async';

import 'package:angular/angular.dart';

import 'fo_button_event.dart';

@Component(
    selector: 'fo-button',
    templateUrl: 'fo_button_component.html',
    styleUrls: const ['fo_button_component.css'],
    directives: const [NgClass],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoButtonComponent implements OnDestroy {
  @Input()
  String label;

  @Input()
  bool leftBorder = true;

  @Input()
  bool rightBorder = true;

  @Input()
  bool disabled = false;

  @Output('trigger')
  Stream<FoButtonEvent> get trigger => _triggerController.stream;

  void onClick() {
    _triggerController.add(FoButtonEvent());
  }

  final StreamController _triggerController = StreamController<FoButtonEvent>();

  FoButtonComponent();

  @override
  void ngOnDestroy() {
    _triggerController.close();
  }
}
