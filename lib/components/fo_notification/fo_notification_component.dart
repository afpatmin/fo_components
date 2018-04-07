import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/fo_components.dart' show PhrasePipe;

/// A notification popup located at the bottom of the screen
/// that can be set to close after a specified duration.
/// It will always start out as visible on creation
@Component(
    selector: 'fo-notification',
    templateUrl: 'fo_notification_component.html',
    styleUrls: const ['fo_notification_component.css'],
    directives: const [MaterialButtonComponent, MaterialIconComponent, NgIf],
    providers: const [],
    pipes: const [PhrasePipe],
    visibility: Visibility.local)
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
