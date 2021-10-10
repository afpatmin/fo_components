import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';

import '../../../src/components/fo_label/fo_label_component.dart';
import '../fo_icon/fo_icon_component.dart';

@Component(
  selector: 'fo-rating',
  templateUrl: 'fo_rating_component.html',
  styleUrls: ['fo_rating_component.css'],
  directives: [FoLabelComponent, FoIconComponent, NgClass, NgFor],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoRatingComponent implements AfterChanges, OnDestroy {
  bool _maxChanged = true;
  int _max = 5;

  @Input()
  bool disabled = false;

  @Input()
  int value = 0;

  @Input()
  String label = '';

  final StreamController<int> _valueChangeController = StreamController();

  List<int> _options = [];

  List<int> get filled =>
      _options.where((o) => value >= o).toList(growable: false);

  int get max => _max;

  @Input()
  set max(int value) {
    _max = value;
    _maxChanged = true;
  }

  List<int> get unfilled =>
      _options.where((o) => value < o).toList(growable: false);

  @Output('valueChange')
  Stream<int> get valueChange => _valueChangeController.stream;

  @override
  void ngAfterChanges() {
    /// Max value has changed, reset starlist
    if (_maxChanged == true) {
      _options = List.generate(max, (i) => i + 1);

      // Reset selected value to max
      value = min(value, max);
      _valueChangeController.add(value);
      _maxChanged = false;
    }
  }

  @override
  void ngOnDestroy() {
    _valueChangeController.close();
  }

  void onRatingClick(int event) {
    if (!disabled) {
      value = (value == event) ? event - 1 : event;
      _valueChangeController.add(value);
    }
  }
}
