import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_components/material_icon/material_icon.dart';

@Component(
  selector: 'fo-rating',
  templateUrl: 'fo_rating_component.html',
  styleUrls: const ['fo_rating_component.css'],
  directives: const [MaterialIconComponent, NgFor],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoRatingComponent implements OnChanges, OnDestroy {
  @Input()
  int max = 5;

  @Input()
  int value;

  final StreamController<int> _valueChangeController = new StreamController();

  List<int> _options = [];

  List<int> get filled => value == null
      ? []
      : _options.where((o) => value >= o).toList(growable: false);

  List<int> get unfilled => value == null
      ? _options
      : _options.where((o) => value < o).toList(growable: false);

  @Output('valueChange')
  Stream<int> get valueChange => _valueChangeController.stream;

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    /// Max value has changed, reset starlist
    if (changes.containsKey('max') &&
        changes['max'].previousValue != changes['max'].currentValue) {
      _options = max == null ? [] : new List.generate(max, (i) => i + 1);

      // Reset selected value to max
      value = max == null ? null : min(value, max);
      _valueChangeController.add(value);
    }
  }

  @override
  void ngOnDestroy() {
    _valueChangeController.close();
  }

  void onRatingClick(int event) {
    value = (value == event) ? event - 1 : event;
    _valueChangeController.add(value);
  }
}
