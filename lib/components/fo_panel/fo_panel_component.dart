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
class FoPanelComponent implements AfterViewInit, OnDestroy {
  final dom.Element _host;
  final ChangeDetectorRef _changeDetectorRef;

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

  dom.Element? innerContent;

  /// Toggle whether or not the panel should be expanded, with its contents visible
  @Input()
  bool expanded = false;

  /// Toggle whether or not the panel should be disabled
  @Input()
  bool disabled = false;

  FoPanelComponent(
    this._host,
    this._changeDetectorRef,
  );

  String get contentHeight => expanded && innerContent != null
      ? '${innerContent?.getBoundingClientRect().height.round()}px'
      : '0';

  @Output('expandedChange')
  Stream<bool> get expandedChange => _expandedChangeController.stream;

  @override
  Future<void> ngAfterViewInit() async {
    /// Give the changedetector some time
    await Future<void>.delayed(const Duration(milliseconds: 100));
    innerContent = _host.querySelector('#contentInner');
  }

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
