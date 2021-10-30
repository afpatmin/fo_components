import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';

import '../fo_icon/fo_icon_component.dart';

@Component(
    selector: 'fo-panel',
    templateUrl: 'fo_panel_component.html',
    styleUrls: ['fo_panel_component.css'],
    directives: [
      NgClass,
      NgStyle,
      NgIf,
      FoIconComponent,
    ],
    pipes: [],
    changeDetection: ChangeDetectionStrategy.Default)

/// Panel component
class FoPanelComponent implements OnDestroy {
  final StreamController<bool> _expandedChangeController = StreamController();

  /// Header, always shown
  @Input()
  String header = '';

  /// Description, shown under the header
  @Input()
  String? description;

  /// Optional material icon to show next to header
  @Input()
  String? icon;

  /// Toggle whether or not the panel should be expanded, with its contents visible
  @Input()
  bool expanded = false;

  /// Toggle whether or not the panel should be disabled
  @Input()
  bool disabled = false;

  FoPanelComponent();

  @Output('expandedChange')
  Stream<bool> get expandedChange => _expandedChangeController.stream;

  @override
  void ngOnDestroy() {
    _expandedChangeController.close();
  }

  void toggleExpanded() {
    if (!disabled) {
      expanded = !expanded;
      _expandedChangeController.add(expanded);
    }
  }
}
