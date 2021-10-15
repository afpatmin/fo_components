import 'dart:async';
import 'dart:html' as html;
import 'dart:html';
import 'dart:math';

import 'package:angular/angular.dart';

@Component(
    selector: 'fo-dropdown',
    templateUrl: 'fo_dropdown_component.html',
    styleUrls: ['fo_dropdown_component.css'],
    directives: [NgClass, NgFor, NgIf, NgStyle],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoDropdownComponent
    implements AfterViewInit, OnDestroy, AfterContentChecked {
  num _width = 0;

  bool _visible = false;

  /// Vertical offset in pixels
  @Input()
  int? offsetTop;

  /// Horizontal offset in pixels
  @Input()
  int? offsetHorizontal;

  /// When this is set to true, the dropdown will stay in the viewport on the vertical axis
  @Input()
  bool constrainToViewPort = true;

  /// Overrides constrainToViewPort
  @Input()
  int? maxHeight;

  final ChangeDetectorRef _changeDetectorRef;

  final StreamController<bool> _visibleController = StreamController<bool>();

  StreamSubscription<html.Event>? _documentScrollSub;
  StreamSubscription<html.Event>? _windowResizeSub;
  int _elementMaxHeight = 100;
  final html.Element host;
  String? height;
  Element? _content;
  FoDropdownComponent(this.host, this._changeDetectorRef);
  String get elementMaxHeight =>
      maxHeight == null ? '${_elementMaxHeight}px' : '${maxHeight}px';

  // ignore: unnecessary_null_comparison
  String get elementWidth => width == 0 ? 'auto' : '${width}px';

  String? get left => offsetHorizontal == null ? null : '${offsetHorizontal}px';
  String get opacity => visible == true ? '1' : '0';
  String? get top => offsetTop == null ? null : '${offsetTop}px';
  bool get visible => _visible;
  @Input()
  set visible(bool flag) {
    _visible = flag;
    height = evaluateHeight();
    if (_visible == true) {
      _evaluateMaxHeight(null);
      Future<void>.delayed(Duration(milliseconds: 1)).then((_) {
        _changeDetectorRef.markForCheck();
        html.document.onClick.first.then((event) {
          if (!_visibleController.isClosed) {
            _visibleController.add(false);
          }
        });
      });
    }
  }

  @Output('visibleChange')
  Stream<bool> get visibleChange => _visibleController.stream;

  num get width => _width;

  /// Width in pixels
  @Input()
  set width(num? v) {
    _width = v ?? 0;
  }

  String evaluateHeight() {
    if (_content == null || visible != true) {
      return '0px';
    }
    final height = _content!.offsetHeight;

    _changeDetectorRef.markForCheck();
    return height > _elementMaxHeight
        ? '${_elementMaxHeight}px'
        : '${height}px';
  }

  @override
  void ngAfterContentChecked() {
    height = evaluateHeight();
    _evaluateMaxHeight(null);
  }

  @override
  void ngAfterViewInit() {
    _content = host.querySelector('#dropdownContent');
    _documentScrollSub = html.document.onScroll.listen(_evaluateMaxHeight);
    _windowResizeSub = html.window.onResize.listen(_evaluateMaxHeight);
  }

  @override
  void ngOnDestroy() {
    _visibleController.close();
    _documentScrollSub?.cancel();
    _windowResizeSub?.cancel();
  }

  void _evaluateMaxHeight(html.Event? e) {
    final parentRect = host.parent!.getBoundingClientRect();
    var newY = parentRect.bottom.round();
    if (constrainToViewPort == true) {
      newY = max(0, newY);
      _elementMaxHeight =
          html.document.documentElement!.clientHeight - newY - 10;
    } else {
      _elementMaxHeight = html.document.body!.clientHeight - newY;
    }
    _changeDetectorRef.markForCheck();
  }
}
