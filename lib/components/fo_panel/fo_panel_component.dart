import 'dart:async';

import 'package:angular/angular.dart';

import '../fo_icon/fo_icon_component.dart';

@Component(
    selector: 'fo-panel',
    templateUrl: 'fo_panel_component.html',
    styleUrls: ['fo_panel_component.css'],
    directives: [
      NgClass,
      NgIf,
      FoIconComponent,
    ],
    pipes: [],
    changeDetection: ChangeDetectionStrategy.OnPush)

/// Panel component
class FoPanelComponent implements OnDestroy {
  FoPanelComponent();

  final StreamController<bool> _expandedChangeController = StreamController();

  /// Header to the panel, always shown
  @Input()
  String? header;

  /// Description of the descripion, shown under the header
  @Input()
  String? description;

  /// Toggle whether or not the panel should be expanded, with its contents visible
  @Input()
  bool expanded = false;

  /// Toggle whether or not the panel should be disabled
  @Input()
  bool disabled = false;

  @Output('expandedChange')
  Stream<bool> get expandedChange => _expandedChangeController.stream;

  void toggleExpanded() {
    if (!disabled) {
      expanded = !expanded;
      _expandedChangeController.add(expanded);
    }
  }

  @override
  void ngOnDestroy() {
    _expandedChangeController.close();
  }
}
