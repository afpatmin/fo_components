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
  int offsetHorizontal = 0;

  /// Target horizontal position in pixels. If set, a marker is shown at the top of the dropdown
  @Input()
  int targetPosition;

  /// When this is set to true, the dropdown will stay in the viewport on the vertical axis
  @Input()
  bool constrainToViewPort = true;

  /// When this is set to true, the dropdown will anchor to the right of it's parent element instead of left
  @Input()
  bool anchorRight = false;

  /// Overrides constrainToViewPort
  @Input()
  int maxHeight;

  StreamSubscription<html.MouseEvent> _onDocumentClickListener;
  final html.Element host;
  final ChangeDetectorRef _changeDetectorRef;
  final StreamController _visibleController = StreamController<bool>();
  StreamSubscription<html.Event> _documentScrollSub;
  StreamSubscription<html.Event> _windowResizeSub;

  String get targetPositonLeft => '${targetPosition}px';

  String get elementMaxHeight =>
      maxHeight == null ? _elementMaxHeight : '${maxHeight}px';

  String _elementMaxHeight = '100px';
  String top;
  String left;
  String right;

  FoDropdownComponent(this.host, this._changeDetectorRef) {
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      _onDocumentClickListener = html.document.onClick.listen((event) {
        if (visible && !_visibleController.isClosed) {
          _visibleController.add(false);
        }
      });
    });
  }

  String get elementWidth => width == null ? 'auto' : '${width}px';

  @Output('visibleChange')
  Stream<bool> get visibleChange => _visibleController.stream;

  @override
  void ngAfterChanges() {
    if (visible == true) {
      _evaluatePosition(null);
    }
  }

  void _evaluatePosition(_) {
    final rect = host.getBoundingClientRect();

    html.Element _findFixedParent(html.Element e) {
      if (e == null) {
        return null;
      } else if (e.style.position == 'fixed' ||
          e.style.transform.contains('translate')) {
        return e;
      }
      return _findFixedParent(e.parent);
    }

    final _fixedParent = _findFixedParent(host);

    if (_fixedParent == null) {
      var newTop = rect.top;
      if (offsetTop != null) {
        newTop += offsetTop;
      }
      if (constrainToViewPort == true) {
        newTop = max(0, newTop);
        _elementMaxHeight =
            '${html.document.documentElement.clientHeight - newTop - 10}px';
      } else {
        _elementMaxHeight =
            '${html.document.body.clientHeight - (newTop + html.window.scrollY)}px';
      }
      top = '${newTop}px';

      if (anchorRight == true) {
        right =
            '${html.document.documentElement.clientWidth - rect.right + offsetHorizontal}px';
        left = null;
      } else {
        left = '${rect.left + offsetHorizontal}px';
        right = null;
      }
    } else {
      final parentRect = _fixedParent.getBoundingClientRect();
      if (offsetTop == null) {
        top = null;
        _elementMaxHeight =
            '${html.document.documentElement.clientHeight - rect.bottom}px';
      } else if (constrainToViewPort == true) {
        final offsetTopClamped = max(0, offsetTop);
        top = '${offsetTopClamped + parentRect.top}px';
        _elementMaxHeight =
            '${html.document.documentElement.clientHeight - rect.bottom - offsetTopClamped}px';
      } else if (constrainToViewPort != true) {
        top = '${offsetTop + parentRect.top}px';
        _elementMaxHeight =
            '${html.document.body.clientHeight - rect.bottom - offsetTop}px';
      }

      if (anchorRight == true) {
        right = '${offsetHorizontal}px';
        left = null;
      } else {
        left = '${rect.left + offsetHorizontal}px';
        right = null;
      }
    }

    offsetHorizontal ??= 0;

    _changeDetectorRef.markForCheck();
  }

  @override
  void ngAfterViewInit() {
    _evaluatePosition(null);

    _documentScrollSub = html.document.onScroll.listen(_evaluatePosition);
    _windowResizeSub = html.window.onResize.listen(_evaluatePosition);
  }

  @override
  void ngOnDestroy() {
    _visibleController.close();
    _documentScrollSub?.cancel();
    _windowResizeSub?.cancel();
    _onDocumentClickListener?.cancel();
  }
}
