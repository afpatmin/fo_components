// Copyright (c) 2017, Patrick. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/material_radio/material_radio.dart';
import 'package:angular_components/material_radio/material_radio_group.dart';
import '../fo_button/fo_button_component.dart';

import 'fo_carousel_slide_component.dart';

@Component(
    selector: 'fo-carousel',
    styleUrls: ['fo_carousel_component.css'],
    templateUrl: 'fo_carousel_component.html',
    directives: [
      FoButtonComponent,
      FoCarouselSlideComponent,
      NgIf,
      MaterialRadioComponent,
      MaterialRadioGroupComponent,
      NgFor
    ],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoCarouselComponent implements OnDestroy, OnInit {
  final StreamController<int> _onStepController = StreamController();
  Timer timer;
  final ChangeDetectorRef _changeDetectorRef;

  @Input()
  int step = 0;

  @Input()
  bool showRadioButtons = false;

  @Input()
  bool showArrowButtons = true;

  @Input()
  bool disabled = false;

  @Input()
  int duration;

  @ContentChildren(FoCarouselSlideComponent)
  List<FoCarouselSlideComponent> slides = [];

  FoCarouselComponent(this._changeDetectorRef);

  @Output('stepChange')
  Stream<int> get stepOutput => _onStepController.stream;

  String get transform => 'translate3d(${-step * 100}%, 0, 0)';

  @override
  void ngOnDestroy() {
    _onStepController.close();
    timer?.cancel();
  }

  @override
  void ngOnInit() {
    if (duration != null) {
      timer =
          Timer.periodic(Duration(milliseconds: duration), (_) => stepBy(1));
    }
  }

  void onButtonChange(int slideNo, bool flag) {
    if (flag) {
      step = slideNo;
      _onStepController.add(step);

      timer?.cancel();
      if (duration != null) {
        timer = Timer(Duration(milliseconds: duration), () => stepBy(1));
      }
      _changeDetectorRef.markForCheck();
    }
  }

  void stepBy(int steps) {
    if (disabled != true) {
      step += steps;
      if (step >= slides.length || step < 0) {
        step = 0;
      }
      _onStepController.add(step);
      timer?.cancel();
      if (duration != null) {
        timer = Timer(Duration(milliseconds: duration), () => stepBy(1));
      }
      _changeDetectorRef.markForCheck();
    }
  }
}
