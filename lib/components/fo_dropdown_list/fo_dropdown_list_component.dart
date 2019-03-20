import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';

import 'fo_dropdown_option.dart';
import 'fo_dropdown_option_component.dart';

@Component(
    selector: 'fo-dropdown-list',
    templateUrl: 'fo_dropdown_list_component.html',
    styleUrls: ['fo_dropdown_list_component.css'],
    directives: [NgClass, NgFor, NgIf, NgStyle, FoDropdownOptionComponent],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoDropdownListComponent
    implements AfterViewInit, AfterChanges, OnDestroy {
  @Input()
  num width;

  @Input()
  bool visible = false;

  @Input()
  Map<String, List<FoDropdownOption>> options;

  @Input()
  String filter;

  final ChangeDetectorRef _changeDetectorRef;
  final html.Element host;
  final StreamController _visibleController = StreamController<bool>();
  final StreamController _selectController =
      StreamController<FoDropdownOption>();
  Map<String, List<FoDropdownOption>> _filteredOptions;

  FoDropdownListComponent(this._changeDetectorRef, this.host);

  String get elementWidth => width == null ? 'auto' : '${width}px';

  String elementMaxHeight = '100px';

  Map<String, List<FoDropdownOption>> get filteredOptions => _filteredOptions;

  @Output('visibleChange')
  Stream<bool> get visibleChange => _visibleController.stream;

  @Output('select')
  Stream<FoDropdownOption> get select => _selectController.stream;

  @override
  void ngAfterChanges() {
    if (visible == true) {
      final rect = host.getBoundingClientRect();
      top = '${rect.top}px';
      
      elementMaxHeight = '${html.document.body.clientHeight + html.window.scrollY - rect.top - 20}px';
      if (filter == null || filter.isEmpty) {
        _filteredOptions = Map.from(options);
      } else {
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
  }

  String top;

  void onSelect(html.Event e, FoDropdownOption option) {
    e.stopPropagation();
    _selectController.add(option);
  }

  @override
  void ngOnDestroy() {
    _visibleController.close();
    _selectController.close();    
  }

  @override
  void ngAfterViewInit() {
    html.document.onScroll.forEach((e) {
      top = '${host.getBoundingClientRect().top}px';
      _changeDetectorRef.markForCheck();
    });

    html.document.onClick.forEach((_) {
      if (visible && !_visibleController.isClosed) {
        _visibleController.add(false);
      }
    });
  }
}
