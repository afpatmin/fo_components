// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

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
    pipes: const [])
class FoModalComponent implements AfterViewInit, OnDestroy {
  FoModalComponent(this.host);

  @override
  void ngAfterViewInit() {
    contentContainer = host.querySelector('.modal-content');
  }

  @override
  void ngOnDestroy() {
    _onVisibleChangeController.close();
  }

  void close() {
    _onVisibleChangeController.add(false);
    visible = false;
  }

  @Input()
  bool visible = false;

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
  bool whiteHeader = true;

  @Input()
  bool smallPadding = true;

  @Input()
  bool showCloseButton = true;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  final html.Element host;
  html.DivElement contentContainer;
  
  final StreamController<bool> _onVisibleChangeController =
      new StreamController();
}
