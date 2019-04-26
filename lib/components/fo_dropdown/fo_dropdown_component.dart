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
  @Input()
  num width;

  @Input()
  bool visible = false;

  @Input()
  int offsetTop = 0;

  @Input()
  bool constrainToViewPort = true;

  StreamSubscription<html.MouseEvent> _onDocumentClickListener;
  final html.Element host;
  final ChangeDetectorRef _changeDetectorRef;
  final StreamController _visibleController = StreamController<bool>();
  StreamSubscription<html.Event> _onDocumentScrollListener;
  StreamSubscription<html.Event> _onWindowResizeListener;

  String elementMaxHeight = '100px';
  String top;

  FoDropdownComponent(this.host, this._changeDetectorRef) {
    _onDocumentClickListener = html.document.onClick.listen((event) {
      if (visible && !_visibleController.isClosed) {
        _visibleController.add(false);
      }
    });
  }

  String get elementWidth => width == null ? 'auto' : '${width}px';

  @Output('visibleChange')
  Stream<bool> get visibleChange => _visibleController.stream;

  @override
  void ngAfterChanges() {
    if (visible == true) {
      final hostRect = host.getBoundingClientRect();

      top = '${hostRect.top + offsetTop}px';

      elementMaxHeight = constrainToViewPort == true
          ? '${html.window.innerHeight - (hostRect.top + offsetTop)}px'
          : '${html.document.body.clientHeight - (hostRect.top + offsetTop + html.window.scrollY)}px';
    }
  }

  @override
  void ngAfterViewInit() {
    html.document.onScroll.listen((e) {
      var newTop = host.getBoundingClientRect().top + offsetTop;
      if (constrainToViewPort == true) {
        newTop = max(0, newTop);
      }
      top = '${newTop}px';
      _changeDetectorRef.markForCheck();
    });
    html.window.onResize.listen((e) {
      var newTop = host.getBoundingClientRect().top + offsetTop;
      if (constrainToViewPort == true) {
        newTop = max(0, newTop);
      }
      top = '${newTop}px';
      _changeDetectorRef.markForCheck();
    });
  }

  @override
  void ngOnDestroy() {
    _visibleController.close();
    _onDocumentScrollListener?.cancel();
    _onWindowResizeListener?.cancel();
    _onDocumentClickListener?.cancel();
  }
}
