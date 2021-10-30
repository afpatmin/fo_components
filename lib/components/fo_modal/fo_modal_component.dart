import 'dart:async';
import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_button/fo_button_component.dart';

@Component(
    selector: 'fo-modal',
    styleUrls: ['fo_modal_component.css'],
    templateUrl: 'fo_modal_component.html',
    directives: [coreDirectives, FoButtonComponent],
    changeDetection: ChangeDetectionStrategy.Default)
class FoModalComponent implements OnDestroy {
  @override
  void ngOnDestroy() {
    _onVisibleChangeController.close();
  }

  void close() {
    _onVisibleChangeController.add(false);
    visible = false;
  }

  @Input()
  String? header;

  @Input()
  String? buttonColor;

  @Input()
  String? buttonBackgroundColor;

  @Input()
  bool materialIcon = true;

  @Input()
  String? error;

  @Input()
  bool visible = false;

  @Input()
  bool showCloseButton = true;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  final StreamController<bool> _onVisibleChangeController = StreamController();
}
