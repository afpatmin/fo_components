// Copyright (c) 2017, Patrick. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'fo_carousel_slide_component.dart';

@Component(
    selector: 'fo-carousel',
    styleUrls: const ['fo_carousel_component.css'],
    templateUrl: 'fo_carousel_component.html',
    directives: const [
      MaterialButtonComponent,
      MaterialIconComponent,
      FoCarouselSlideComponent,
      NgIf,
      MaterialRadioComponent,
      MaterialRadioGroupComponent,
      NgFor
    ],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoCarouselComponent implements OnDestroy, OnInit {
  FoCarouselComponent(this._changeDetectorRef);

  @override
  void ngOnDestroy() {
    _onStepController.close();
    timer?.cancel();
  }

  @override
  void ngOnInit() {
    if (duration != null) {
      timer = new Timer.periodic(
          new Duration(milliseconds: duration), (_) => stepBy(1));
    }
  }

  void stepBy(int steps) {
    step += steps;
    if (step >= slides.length || step < 0) {
      step = 0;
    }
    _onStepController.add(step);
    timer?.cancel();
    if (duration != null) {
      timer = new Timer(new Duration(milliseconds: duration), () => stepBy(1));
    }
    _changeDetectorRef.markForCheck();
  }

  void onButtonChange(int slideNo, bool flag) {
    if (flag) {
      step = slideNo;
      _onStepController.add(step);

      timer?.cancel();
      if (duration != null) {
        timer =
            new Timer(new Duration(milliseconds: duration), () => stepBy(1));
      }
      _changeDetectorRef.markForCheck();
    }
  }

  String get transform => 'translate3d(${-step * 100}%, 0, 0)';

  final StreamController<int> _onStepController = new StreamController();
  Timer timer;
  final ChangeDetectorRef _changeDetectorRef;

  @Input()
  int step = 0;

  @Input()
  bool showRadioButtons = false;

  @Input()
  bool showArrowButtons = true;

  @Input()
  int duration;

  @Output('stepChange')
  Stream<int> get stepOutput => _onStepController.stream;

  @ContentChildren(FoCarouselSlideComponent)
  List<FoCarouselSlideComponent> slides = [];
}
