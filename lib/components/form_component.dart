// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library form_component;

import 'package:angular2/core.dart';

@Component(
    selector: 'fo-form',
    styleUrls: const ['style/form_component.css'],
    templateUrl: 'html/form_component.html',
    preserveWhitespace: false,
    changeDetection: ChangeDetectionStrategy.Default)

class FormComponent extends ComponentState
{
  FormComponent();
}
