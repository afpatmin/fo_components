import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';

import 'fo_dropdown_option.dart';
import 'fo_dropdown_option_component.dart';

@Component(
    selector: 'fo-dropdown-list',
    templateUrl: 'fo_dropdown_list_component.html',
    styleUrls: const ['fo_dropdown_list_component.css'],
    directives: const [
      NgClass,
      NgFor,
      NgIf,
      NgStyle,
      FoDropdownOptionComponent
    ],
    changeDetection: ChangeDetectionStrategy.OnPush)
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

  
  int _startOffsetTop;
  final html.Element host;
  final StreamController _visibleController = StreamController<bool>();
  final StreamController selectController =
      StreamController<FoDropdownOption>();
  Map<String, List<FoDropdownOption>> _filteredOptions;

  FoDropdownListComponent(this.host);

  String get elementWidth => width == null ? 'auto' : '${width}px';

  String get elementMaxHeight =>
      '${html.window.innerHeight - host.offsetTop - 40}px';

  Map<String, List<FoDropdownOption>> get filteredOptions => _filteredOptions;

  @Output('visibleChange')
  Stream<bool> get visibleChange => _visibleController.stream;

  @Output('select')
  Stream<FoDropdownOption> get select => selectController.stream;

  @override
  void ngAfterChanges() {
    if (visible == true) {
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
    selectController.close();
  }

  @override
  void ngOnInit() {
    // Make sure the element stays in position
    html.document.onScroll.forEach((_) {
      host.style.top =
          '${_startOffsetTop - html.document.documentElement.scrollTop}px';
    });
  }

  @override
  void ngAfterViewInit() {
    _startOffsetTop = host.offsetTop;
    host.style.top =
          '${_startOffsetTop - html.document.documentElement.scrollTop}px';
  }
}
