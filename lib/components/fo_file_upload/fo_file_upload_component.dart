import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';

import '../../pipes/capitalize_pipe.dart';
import '../fo_button/fo_button_component.dart';
import '../fo_icon/fo_icon_component.dart';

@Component(
    selector: 'fo-file-upload',
    templateUrl: 'fo_file_upload_component.html',
    styleUrls: ['fo_file_upload_component.css'],
    directives: [NgIf, FoButtonComponent, FoIconComponent],
    pipes: [CapitalizePipe],
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
    if (disabled != true) {
      final dt = event.dataTransfer;
      file = (dt.files.isEmpty) ? null : file = dt.files.last;
    }
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
