import 'dart:async';
import 'dart:html' as html;
import 'dart:math';

import 'package:angular/angular.dart';

@Component(
    selector: 'fo-dropdown',
    templateUrl: 'fo_dropdown_component.html',
    styleUrls: ['fo_dropdown_component.css'],
    directives: [NgClass, NgFor, NgIf, NgStyle],
    pipes: [])
class FoDropdownComponent implements AfterViewInit, AfterChanges, OnDestroy {
  /// Width in pixels
  @Input()
  num width;

  @Input()
  bool visible = false;

  /// Vertical offset in pixels
  @Input()
  int offsetTop;

  /// Horizontal offset in pixels
  @Input()
  int offsetHorizontal;

  /// Target horizontal position in pixels. If set, a marker is shown at the top of the dropdown
  @Input()
  int targetPosition;

  /// When this is set to true, the dropdown will stay in the viewport on the vertical axis
  @Input()
  bool constrainToViewPort = true;

  /// Overrides constrainToViewPort
  @Input()
  int maxHeight;

  final html.Element host;
  final ChangeDetectorRef _changeDetectorRef;
  final StreamController _visibleController = StreamController<bool>();
  StreamSubscription<html.Event> _documentScrollSub;
  StreamSubscription<html.Event> _windowResizeSub;

  String get targetPositonLeft => '${targetPosition}px';

  String get elementMaxHeight =>
      maxHeight == null ? _elementMaxHeight : '${maxHeight}px';

  String _elementMaxHeight = '100px';
  String get top => offsetTop == null ? null : '${offsetTop}px';
  String get left => offsetHorizontal == null ? null : '${offsetHorizontal}px';

  FoDropdownComponent(this.host, this._changeDetectorRef);

  String get elementWidth => width == null ? 'auto' : '${width}px';

  @Output('visibleChange')
  Stream<bool> get visibleChange => _visibleController.stream;

  @override
  void ngAfterChanges() {
    if (visible == true) {
      _evaluateMaxHeight(null);
      Future.delayed(Duration(milliseconds: 1)).then((_) {
        html.document.onClick.first.then((event) {
          if (!_visibleController.isClosed) {
            _visibleController.add(false);
          }
        });
      });
    }
  }

  void _evaluateMaxHeight(_) {
    final parentRect = host.parent.getBoundingClientRect();
    var newY = parentRect.bottom;
    if (constrainToViewPort == true) {
      newY = max(0, newY);
      _elementMaxHeight =
          '${html.document.documentElement.clientHeight - newY - 10}px';
    } else {
      _elementMaxHeight = '${html.document.body.clientHeight - newY}px';
    }
    _changeDetectorRef.markForCheck();
  }

  @override
  void ngAfterViewInit() {
    _evaluateMaxHeight(null);

    _documentScrollSub = html.document.onScroll.listen(_evaluateMaxHeight);
    _windowResizeSub = html.window.onResize.listen(_evaluateMaxHeight);
  }

  @override
  void ngOnDestroy() {
    _visibleController.close();
    _documentScrollSub?.cancel();
    _windowResizeSub?.cancel();
  }
}
