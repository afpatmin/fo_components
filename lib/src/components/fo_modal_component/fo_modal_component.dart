// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/src/pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-modal',
    styleUrls: const ['fo_modal_component.css'],
    templateUrl: 'fo_modal_component.html',
    directives: const [materialDirectives],
    pipes: const [PhrasePipe]
)
class FoModalComponent implements OnDestroy
{
  FoModalComponent();

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
  }

  void close()
  {
    _onVisibleChangeController.add(false);
    visible = false;
  }

  @Input('visible')
  bool visible = false;

  @Input('title')
  String title = "";

  @Input('error')
  String error;

  @Input('fixedWidth')
  bool fixedWidth = false;

  @Input('fixedHeight')
  bool fixedHeight = false;

  @Input('showCloseButton')
  bool showCloseButton = true;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  final StreamController<bool> _onVisibleChangeController = new StreamController();
}
