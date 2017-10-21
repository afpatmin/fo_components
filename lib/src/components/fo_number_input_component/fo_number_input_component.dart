// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-number-input',
    styleUrls: const ['fo_number_input_component.css'],
    templateUrl: 'fo_number_input_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives],
    pipes: const [PhrasePipe]
)
class FoNumberInputComponent implements OnDestroy
{
  FoNumberInputComponent();

  void ngOnDestroy()
  {
    _onValueChangeController.close();
  }

  void onAdd(int count)
  {
    value += count;
    _onValueChangeController.add(value);
  }

  final StreamController<int> _onValueChangeController = new StreamController();

  @Input('label')
  String label = "value";

  @Input('leadingText')
  String leadingText = "";

  @Input('max')
  int max = 9999;

  @Input('min')
  int min = 0;

  @Input('trailingText')
  String trailingText = "";

  @Input('value')
  int value = 0;

  @Output('valueChange')
  Stream<int> get onValueChangeOutput => _onValueChangeController.stream;
}
