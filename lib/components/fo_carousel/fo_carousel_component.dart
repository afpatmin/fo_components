// Copyright (c) 2017, Patrick. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'fo_carousel_slide_component.dart';

@Component(
    selector: 'fo-carousel',
    styleUrls: const ['fo_carousel_component.css'],
    templateUrl: 'fo_carousel_component.html',
    directives: const [MaterialButtonComponent, MaterialIconComponent, FoCarouselSlideComponent]    
)
class FoCarouselComponent implements OnDestroy
{
  @override
  void ngOnDestroy()
  {
    _onStepController.close();
  }

  void stepBy(int steps)
  {
    step += steps;
    step = min(max(0, step), slides.length - 1);
    _onStepController.add(step);
  }

  String get transform => 'translateX(${-step * 100}%)';

  final StreamController<int> _onStepController = new StreamController();

  @Input('step')
  int step = 0;

  @Output('stepChange')
  Stream<int> get stepOutput => _onStepController.stream;

  @ContentChildren(FoCarouselSlideComponent)
  List<FoCarouselSlideComponent> slides = [];
}
