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
  int offsetTop = 0;

  /// Horizontal offset in pixels
  @Input()
  int offsetHorizontal = 0;

  /// When this is set to true, the dropdown will stay in the viewport on the vertical axis
  @Input()
  bool constrainToViewPort = true;

  /// When this is set to true, the dropdown will anchor to the right of it's parent element instead of left
  @Input()
  bool anchorRight = false;

  StreamSubscription<html.MouseEvent> _onDocumentClickListener;
  final html.Element host;
  final ChangeDetectorRef _changeDetectorRef;
  final StreamController _visibleController = StreamController<bool>();
  StreamSubscription<html.Event> _documentScrollSub;
  StreamSubscription<html.Event> _windowResizeSub;

  String elementMaxHeight = '100px';
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

    html.Element findFixedParent(html.Element e) {
      if (e == null) {
        return null;
      } else if (e.getComputedStyle().position == 'fixed') {
        return e;
      }
      return findFixedParent(e.parent);
    }

    final fixedParent = findFixedParent(host);
    if (fixedParent == null) {
      var newTop = rect.top + offsetTop;
      if (constrainToViewPort == true) {
        newTop = max(0, newTop);
        elementMaxHeight =
            '${html.document.documentElement.clientHeight - newTop}px';
      } else {
        elementMaxHeight =
            '${html.document.body.clientHeight - (newTop + html.window.scrollY)}px';
      }
      top = '${newTop}px';
    } else {
      final hostRect = host.getBoundingClientRect();
      final parentRect = fixedParent.getBoundingClientRect();
      if (offsetTop == null) {
        top = null;
        elementMaxHeight =
            '${html.document.documentElement.clientHeight - hostRect.bottom}px';
      } else if (constrainToViewPort == true) {
        final offsetTopClamped = max(0, offsetTop);
        top = '${offsetTopClamped + parentRect.top}px';
        elementMaxHeight =
            '${html.document.documentElement.clientHeight - hostRect.bottom - offsetTopClamped}px';
      } else if (constrainToViewPort != true) {
        top = '${offsetTop + parentRect.top}px';
        elementMaxHeight =
            '${html.document.body.clientHeight - hostRect.bottom - offsetTop}px';
      }
    }

    offsetHorizontal ??= 0;

    if (anchorRight == true) {
      right =
          '${html.document.documentElement.clientWidth - rect.right + offsetHorizontal}px';
      left = null;
    } else {
      left =
          '${rect.left + offsetHorizontal}px';
      right = null;
    }

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
