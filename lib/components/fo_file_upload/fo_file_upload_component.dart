// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as dom;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../services/fo_messages_service.dart';

@Component(
    selector: 'fo-file-upload',
    templateUrl: 'fo_file_upload_component.html',
    styleUrls: const ['fo_file_upload_component.css'],
    directives: const [coreDirectives, materialDirectives],
    pipes: const [])
class FileUploadComponent implements OnDestroy
{
  FileUploadComponent(this.msg);

  @override
  void ngOnDestroy()
  {
    onUploadController.close();
  }

  void onDrop(dom.MouseEvent event)
  {
    event.preventDefault();
    final dt = event.dataTransfer;
    file = (dt.files.isEmpty) ? null : file = dt.files.last;
  }

  void onFileChange(dom.Event event)
  {
    _fileInput = event.target;
    file = (_fileInput.files.isNotEmpty) ? _fileInput.files.last : null;
  }

  void clearSelection()
  {
    file = null;
    _fileInput?.value = '';
  }

  void upload()
  {
    onUploadController.add(file);
    clearSelection();
  }

  bool get valid => file != null && file.size <= maxByteSize;

  final StreamController<dom.File> onUploadController = new StreamController();
  dom.FileUploadInputElement _fileInput;
  dom.File file;
  final FoMessagesService msg;

  @Input()
  String accept = 'image/*,.pdf';

  @Input()
  bool disabled = false;

  @Input()
  String label = 'File';

  @Input()
  int maxByteSize = 1048576;

  @Output('upload')
  Stream<dom.File> get onUploadOutput => onUploadController.stream;


}
