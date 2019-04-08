import 'dart:async';

import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_button/fo_button_component.dart';

/// A notification popup shown at the bottom of the screen.
/// It can be set to close after a specified duration,
/// and will always start out as visible on init
@Component(
    selector: 'fo-notification',
    templateUrl: 'fo_notification_component.html',
    styleUrls: ['fo_notification_component.css'],
    directives: [FoButtonComponent, NgIf],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoNotificationComponent implements OnInit, OnDestroy {
  final ChangeDetectorRef _changeDetectorRef;

  bool _isOpen = true;

  StreamController<String> _onCloseController = StreamController();

  @Input()
  bool showCloseButton = true;

  @Input()
  String header = 'Notification';

  @Input()
  int visibleSeconds;

  FoNotificationComponent(this._changeDetectorRef);
  bool get isOpen => _isOpen;

  @Output('close')
  Stream<String> get onClose => _onCloseController.stream;

  void close() {
    _onCloseController?.add('');
    _isOpen = false;
    _changeDetectorRef.markForCheck();
  }

  @override
  void ngOnDestroy() {
    _onCloseController.close();
    _onCloseController = null;
  }

  @override
  void ngOnInit() {
    if (visibleSeconds != null) {
      Future.delayed(Duration(seconds: visibleSeconds)).then((_) => close());
    }
  }
}
