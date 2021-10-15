import 'dart:async';

import 'package:angular/angular.dart';

import 'fo_radio_component.dart';

@Component(
  selector: 'fo-radio-group',
  templateUrl: 'fo_radio_group_component.html',
  styleUrls: ['fo_radio_group_component.css'],
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoRadioGroupComponent implements AfterContentInit, OnDestroy {
  final StreamController<Object?> _valueChangeController =
      StreamController<Object?>();

  @ContentChildren(FoRadioComponent)
  List<FoRadioComponent>? children;

  @Output('valueChange')
  Stream<Object?> get valueChange => _valueChangeController.stream;

  Object? _value;

  @Input()
  set value(Object? v) {
    _value = v;
    if (children != null) {
      for (final child in children!) {
        if (v == child.value) {
          child.checked = true;
        } else {
          child.checked = false;
        }
      }
    }
  }

  final List<StreamSubscription<Object?>> _subs = [];

  final ChangeDetectorRef _changeDetectorRef;
  FoRadioGroupComponent(this._changeDetectorRef);

  @override
  void ngAfterContentInit() {
    for (final child in children!) {
      if (_value == child.value) {
        child.checked = true;
      } else {
        child.checked = false;
      }
      _subs.add(child.checkedChange.listen((state) {
        _value = state;
        _valueChangeController.add(state);

        for (final c in children!) {
          if (c != child) {
            c.checked = false;
            _changeDetectorRef.markChildForCheck(c);
          }
        }
      }));
    }
  }

  @override
  void ngOnDestroy() {
    for (final sub in _subs) {
      sub.cancel();
    }
    _valueChangeController.close();
  }
}
