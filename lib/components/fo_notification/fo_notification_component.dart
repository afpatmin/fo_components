import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_icon/material_icon.dart';

/// A notification popup located at the bottom of the screen
/// that can be set to close after a specified duration.
/// It will always start out as visible on creation
@Component(
    selector: 'fo-notification',
    templateUrl: 'fo_notification_component.html',
    styleUrls: const ['fo_notification_component.css'],
    directives: const [MaterialButtonComponent, MaterialIconComponent, NgIf],
    providers: const [],
    pipes: const [],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoNotificationComponent implements OnInit, OnDestroy {
  FoNotificationComponent();

  @override
  void ngOnInit() {
    if (visibleSeconds != null) {
      new Future.delayed(new Duration(seconds: visibleSeconds))
          .then((_) => close());
    }
  }

  @override
  void ngOnDestroy() {
    _onCloseController.close();
    _onCloseController = null;
  }

  void close() {
    _onCloseController?.add('');
    _isOpen = false;
  }

  bool get isOpen => _isOpen;

  bool _isOpen = true;
  StreamController<String> _onCloseController = new StreamController();

  @Input()
  bool showCloseButton = true;

  @Input()
  String header = 'notification';

  @Input()
  int visibleSeconds;

  @Output('close')
  Stream<String> get onClose => _onCloseController.stream;
}
