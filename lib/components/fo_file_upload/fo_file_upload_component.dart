// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'fo-file-upload',
    templateUrl: 'fo_file_upload_component.html',
    styleUrls: ['fo_file_upload_component.css'],
    directives: [NgIf, MaterialButtonComponent, MaterialIconComponent],
    pipes: [],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FileUploadComponent implements OnDestroy {
  final StreamController<dom.File> onUploadController = StreamController();

  dom.FileUploadInputElement _fileInput;

  dom.File file;

  final String msgMaxFilesizeExceeded =
      Intl.message('max filesize exceeded', name: 'max_filesize_exceeded');

  @Input()
  String accept = 'image/*,.pdf';

  @Input()
  bool disabled = false;

  @Input()
  String label = 'File';

  @Input()
  int maxByteSize = 1048576;
  FileUploadComponent();
  @Output('upload')
  Stream<dom.File> get onUploadOutput => onUploadController.stream;
  bool get valid => file != null && file.size <= maxByteSize;

  void clearSelection() {
    file = null;
    _fileInput?.value = '';
  }

  @override
  void ngOnDestroy() {
    onUploadController.close();
  }

  void onDrop(dom.MouseEvent event) {
    event.preventDefault();
    final dt = event.dataTransfer;
    file = (dt.files.isEmpty) ? null : file = dt.files.last;
  }

  void onFileChange(dom.Event event) {
    _fileInput = event.target;
    file = (_fileInput.files.isNotEmpty) ? _fileInput.files.last : null;
  }

  void upload() {
    onUploadController.add(file);
    clearSelection();
  }
}
