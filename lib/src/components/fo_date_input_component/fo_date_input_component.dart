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
class FoDateInputComponent implements OnDestroy, AfterViewInit
{
  FoDateInputComponent()
  {
  }

  void ngAfterViewInit()
  {
    _inputElement = inputRef.nativeElement;
  }

  void ngOnDestroy()
  {
    onValueChangeController.close();
  }

  final StreamController<DateTime> onValueChangeController = new StreamController();
  html.DateInputElement _inputElement;

  @Input('disabled')
  bool disabled = false;

  @Input('label')
  String label = "date";

  @Input('value')
  void set value(DateTime dt) => _inputElement.valueAsDate = dt;

  @Output('valueChange')
  Stream<DateTime> get onValueChangeOutput => onValueChangeController.stream;

  @ViewChild('input')
  ElementRef inputRef;
}
