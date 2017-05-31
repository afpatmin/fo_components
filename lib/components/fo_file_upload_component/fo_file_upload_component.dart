// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as dom show File, FileUploadInputElement;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'fo-file-upload',
    templateUrl: 'fo_file_upload_component.html',
    styleUrls: const ['fo_file_upload_component.css'],
    directives: const [materialDirectives],
    providers: const [])
class FileUploadComponent implements OnDestroy
{
  FileUploadComponent();

  void ngOnDestroy()
  {
    onUploadController.close();
  }

  void onFileChange(dynamic event)
  {
    _fileInput = event.target;
    file = (_fileInput.files.isNotEmpty) ? _fileInput.files.last : null;
  }

  dom.FileUploadInputElement _fileInput;
  dom.File file;

  @Input('title')
  String title = "Upload file";

  @Input('disabled')
  bool disabled = false;

  @Output('upload')
  Stream<dom.File> get onUploadOutput => onUploadController.stream;

  StreamController<dom.File> onUploadController = new StreamController();
}
