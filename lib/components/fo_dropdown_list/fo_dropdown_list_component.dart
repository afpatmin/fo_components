import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';

import 'fo_dropdown_option.dart';
import 'fo_dropdown_option_component.dart';

@Component(
    selector: 'fo-dropdown-list',
    templateUrl: 'fo_dropdown_list_component.html',
    styleUrls: const ['fo_dropdown_list_component.css'],
    directives: const [NgFor, NgIf, NgStyle, FoDropdownOptionComponent])
class FoDropdownListComponent implements AfterChanges, OnDestroy {
  @Input()
  num width;

  @Input()
  bool visible = false;

  @Input()
  Map<String, List<FoDropdownOption>> options;

  final html.Element host;
  final ChangeDetectorRef _changeDetectorRef;
  final StreamController _visibleController = StreamController<bool>();
  StreamSubscription<html.Event> _scrollListener;
  String elementMaxHeight;

  FoDropdownListComponent(this.host, this._changeDetectorRef) {
    _scrollListener = html.document.onScroll.listen((_) {
      visible = false;
      _visibleController.add(false);
      _changeDetectorRef.markForCheck();
    });
  }

  String get elementWidth => width == null ? 'auto' : '${width}px';

  @Output('visibleChange')
  Stream<bool> get visibleChange => _visibleController.stream;

  @override
  void ngAfterChanges() {
    if (visible == true) {
      elementMaxHeight =
          '${html.document.documentElement.clientHeight - host.offsetTop}px';
    }
  }

  @override
  void ngOnDestroy() {
    _visibleController.close();
    _scrollListener?.cancel();
  }
}
