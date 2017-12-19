// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import '../../pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-date-input',
    templateUrl: 'fo_date_input_component.html',
    styleUrls: const ['fo_date_input_component.scss.css'],
    directives: const [CORE_DIRECTIVES],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.none)
class FoDateInputComponent implements OnDestroy
{
  FoDateInputComponent(html.Element host)
  {
    input = host.querySelector("#input");
  }

  void ngOnDestroy()
  {
    onValueChangeController.close();
  }

  final StreamController<DateTime> onValueChangeController = new StreamController();
  html.DateInputElement input;

  @Input('disabled')
  bool disabled = false;

  @Input('label')
  String label = "date";

  @Input('value')
  void set value(DateTime dt) => input.valueAsDate = dt;

  @Output('valueChange')
  Stream<DateTime> get onValueChangeOutput => onValueChangeController.stream;
}
