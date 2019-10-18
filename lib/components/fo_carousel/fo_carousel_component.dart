// Copyright (c) 2017, Patrick. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as dom;
import 'dart:math' as math;

import 'package:angular/angular.dart';
import 'package:angular_components/material_radio/material_radio.dart';
import 'package:angular_components/material_radio/material_radio_group.dart';
import 'package:fo_components/components/fo_icon/fo_icon_component.dart';

import 'fo_carousel_slide_component.dart';

@Component(
    selector: 'fo-carousel',
    styleUrls: ['fo_carousel_component.css'],
    templateUrl: 'fo_carousel_component.html',
    directives: [
      FoIconComponent,
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
  final int _verticalThreshold;
  int prevX;
  int _deltaX = 0;
  Timer _scrollTimer;
  int _step = 0;
  bool _animateSlides = true;
  bool _animateSlidesSetting = true;

  @Input()
  bool materialIcons = true;

  @Input()
  String nextIcon = 'keyboard_arrow_right';

  @Input()
  String prevIcon = 'keyboard_arrow_left';

  @Input()
  bool showRadioButtons = false;

  @Input()
  bool showArrowButtons = true;

  @Input()
  bool disabled = false;

  @Input()
  bool loop = false;

  @Input()
  int duration;

  double dragOffset = 0.0;

  @ContentChildren(FoCarouselSlideComponent)
  List<FoCarouselSlideComponent> slides = [];

  FoCarouselComponent(this._changeDetectorRef);

  bool get animateSlides => _animateSlides;

  @Input()
  set animateSlides(bool value) {
    _animateSlidesSetting = value;
    _animateSlides = value;
  }

  int get step => _step;

  @Input()
  set step(int value) {
    if (_step != value) {
      _disableSlideAnimation();
      _step = value;
    }
  }

  @Output('stepChange')
  Stream<int> get stepOutput => _onStepController.stream;

  String get transform => 'translate3d(${-(step + dragOffset) * 100}%, 0, 0)';

  @override
  void ngOnDestroy() {
    _onStepController.close();
    timer?.cancel();
    _scrollTimer?.cancel();
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
      _step = slideNo;
      _onStepController.add(step);

      timer?.cancel();
      if (duration != null) {
        timer = Timer(Duration(milliseconds: duration), () => stepBy(1));
      }
      _changeDetectorRef.markForCheck();
    }
  }

  void onTouchEnd(dom.TouchEvent event) {
    dragOffset = 0.0;
    if (disabled == true) {
      return;
    }

    void disableWhileStepping() {
      disabled = true;
      _scrollTimer = Timer(const Duration(milliseconds: 200), () {
        disabled = false;
        _scrollTimer = null;
        prevX = null;
      });
    }

    if (_deltaX < -_verticalThreshold) {
      stepBy(-1);
      disableWhileStepping();
    } else if (_deltaX > _verticalThreshold) {
      stepBy(1);
      disableWhileStepping();
    }

    _deltaX = 0;
  }

  void onTouchMove(dom.TouchEvent event) {
    if (disabled == true) {
      return;
    }

    final x = event.touches.first.screen.x;
    prevX ??= x;
    _deltaX = prevX - x;
    if (_deltaX > _verticalThreshold || _deltaX < -_verticalThreshold) {
      dragOffset = math.max(-0.2, math.min(0.2, _deltaX.toDouble()));
    }
  }

  void stepBy(int steps) {
    if (disabled != true) {
      if (loop == true) {
        _step += steps;
        if (step >= slides.length) {
          _disableSlideAnimation();
          _step = 0;
        } else if (step < 0) {
          _disableSlideAnimation();
          _step = slides.length - 1;
        }
      } else {
        _step += steps;
        if (step >= slides.length || step < 0) {
          _disableSlideAnimation();
          _step = 0;
        }
      }

      _onStepController.add(step);
      timer?.cancel();
      if (duration != null) {
        timer = Timer(Duration(milliseconds: duration), () => stepBy(1));
      }
      _changeDetectorRef.markForCheck();
    }
  }

  /// Don't animate slides for a specified duration (200ms by default)
  void _disableSlideAnimation(
      {duration = const Duration(milliseconds: 200)}) async {
    _animateSlides = false;
    await Future.delayed(duration);
    _animateSlides = _animateSlidesSetting;
    _changeDetectorRef.markForCheck();
  }
}
