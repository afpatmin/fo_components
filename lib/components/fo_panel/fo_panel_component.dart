import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_button/fo_button_component.dart';
import '../../pipes/capitalize_pipe.dart';

@Component(
    selector: 'fo-panel',
    templateUrl: 'fo_panel_component.html',
    styleUrls: ['fo_panel_component.css'],
    directives: [
      FoButtonComponent,
      NgIf,
    ],
    pipes: [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)

/// Panel component
class FoPanelComponent {
  FoPanelComponent();

  /// Header to the panel
  @Input()
  String? header;

  /// Description of component

  @Input()
  String? description;

  /// Show expanded panel
  @Input()
  bool expanded = false;

  void toggleExpanded() {
    expanded = !expanded;
  }
}
