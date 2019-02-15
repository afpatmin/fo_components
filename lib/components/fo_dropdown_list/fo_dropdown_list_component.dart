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
class FoDropdownListComponent
    implements OnInit, AfterViewInit, AfterChanges, OnDestroy {
  @Input()
  num width;

  @Input()
  bool visible = false;

  @Input()
  Map<String, List<FoDropdownOption>> options;

  @Input()
  String filter;

  int startOffsetTop;
  final html.Element host;
  StreamSubscription<html.Event> _scrollListener;
  final StreamController _visibleController = StreamController<bool>();
  final StreamController selectController =
      StreamController<FoDropdownOption>();
  Map<String, List<FoDropdownOption>> _filteredOptions;
  String elementMaxHeight;

  FoDropdownListComponent(this.host);

  String get elementWidth => width == null ? 'auto' : '${width}px';

  Map<String, List<FoDropdownOption>> get filteredOptions => _filteredOptions;

  @Output('visibleChange')
  Stream<bool> get visibleChange => _visibleController.stream;

  @Output('select')
  Stream<FoDropdownOption> get select => selectController.stream;

  @override
  void ngAfterChanges() {
    if (visible == true) {
      elementMaxHeight =
          '${html.document.documentElement.clientHeight - host.offsetTop}px';

      _filteredOptions = {};
      for (final category in options.keys) {
        _filteredOptions[category] = options[category]
            .where((option) =>
                option.label.toLowerCase().contains(filter.toLowerCase()))
            .toList(growable: false);
        if (_filteredOptions[category].isEmpty) {
          _filteredOptions.remove(category);
        }
      }
      if (_filteredOptions.isEmpty) {
        _visibleController.add(false);
      }
    }
  }

  @override
  void ngOnDestroy() {
    _visibleController.close();
    _scrollListener?.cancel();
    selectController.close();
  }

  @override
  void ngOnInit() {
    _scrollListener = html.document.onScroll.listen((_) {
      host.style.top =
          '${startOffsetTop - html.document.documentElement.scrollTop}px';
    });
  }

  @override
  void ngAfterViewInit() {
    startOffsetTop = host.offsetTop;
  }
}
