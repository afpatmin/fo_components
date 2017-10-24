// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-multi-input',
    styleUrls: const ['fo_multi_input_component.scss.css'],
    templateUrl: 'fo_multi_input_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives],
    pipes: const [PhrasePipe],
    visibility: Visibility.none
)
class FoMultiInputComponent implements OnDestroy
{
  FoMultiInputComponent();

  void ngOnDestroy()
  {
    _onValueChangeController.close();
  }

  void onKeyUp(html.KeyboardEvent e)
  {
    if (e.keyCode == html.KeyCode.ENTER || e.keyCode == html.KeyCode.MAC_ENTER) add();
  }

  void add()
  {
    if (inputValue.isNotEmpty)
    {
      value.add(inputValue);
      _onValueChangeController.add(value);
      inputValue = "";
    }
  }

  void remove(String item)
  {
    value.remove(item);
    _onValueChangeController.add(value);
  }

  @Input('label')
  String label;

  @Input('maxLength')
  String maxLength;

  String inputValue = "";

  final StreamController<List<String>> _onValueChangeController = new StreamController();

  @Input('value')
  List<String> value = new List();

  @Output('valueChange')
  Stream<List<String>> get onValueChangeOutput => _onValueChangeController.stream;
}
