// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_components/laminate/components/modal/modal.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_dialog/material_dialog.dart';
import 'package:angular_components/material_icon/material_icon.dart';

@Component(
    selector: 'fo-modal',
    styleUrls: const ['fo_modal_component.css'],
    templateUrl: 'fo_modal_component.html',
    directives: const [
      coreDirectives,
      MaterialButtonComponent,
      MaterialDialogComponent,
      MaterialIconComponent,
      ModalComponent,
    ],
    pipes: const [],
    changeDetection: ChangeDetectionStrategy.Default)
class FoModalComponent implements OnDestroy {
  FoModalComponent();

  @override
  void ngOnDestroy() {
    _onVisibleChangeController.close();
    html.document.body.style.overflow = '';
  }

  void close() {
    _onVisibleChangeController.add(false);
    visible = false;
    html.document.body.style.overflow = '';
  }

  bool get visible => _visible;

  @Input()
  set visible(bool flag) {
    _visible = flag;
    if (_visible) {
      html.document.body.style.overflow = 'hidden';
    } else {
      html.document.body.style.removeProperty('overflow');
    }
  }

  @Input()
  String title;

  @Input()
  String titleImageUrl;

  @Input()
  String error;

  @Input()
  bool fixedWidth = false;

  @Input()
  bool fixedHeight = false;

  @Input()
  bool smallPadding = true;

  @Input()
  bool showCloseButton = true;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  final StreamController<bool> _onVisibleChangeController =
      new StreamController();

  bool _visible = false;
}
