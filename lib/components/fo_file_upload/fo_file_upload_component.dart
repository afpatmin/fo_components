import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';

import '../../../src/components/fo_label/fo_label_component.dart';
import '../../pipes/capitalize_pipe.dart';
import '../fo_icon/fo_icon_component.dart';
import '../fo_load_indicator/fo_load_indicator_component.dart';

@Component(
    selector: 'fo-file-upload',
    templateUrl: 'fo_file_upload_component.html',
    styleUrls: ['fo_file_upload_component.css'],
    directives: [
      NgIf,
      FoIconComponent,
      FoLabelComponent,
      FoLoadIndicatorComponent,
    ],
    pipes: [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)

/// A component which lets the user select or drop a single file from their
/// local drive. When the file has been processed, a fileChange event is fired
/// containing the File object. The host app can optionally set [uploading]
/// to true to display a load indicator
class FoFileUploadComponent implements OnDestroy {
  final StreamController<dom.File> _fileController = StreamController();
  dom.FileUploadInputElement? _fileInput;
  dom.File? file;

  @Input()
  String accept = 'image/*,.pdf';

  @Input()
  bool materialIcon = true;

  @Input()
  bool disabled = false;

  @Input()
  String label = 'Select a file';

  @Input()
  String uploadingLabel = 'Uploading...';

  @Input()
  bool uploading = false;

  @Output('fileChange')
  Stream<dom.File> get onFileChangedOutput => _fileController.stream;

  void clearSelection() {
    file = null;
    _fileInput?.value = '';
  }

  @override
  void ngOnDestroy() {
    _fileController.close();
  }

  void onDrop(dom.MouseEvent event) {
    event.preventDefault();
    if (disabled == false && uploading == false) {
      final dt = event.dataTransfer;
      file = (dt.files!.isEmpty) ? null : file = dt.files!.last;
      if (file != null) {
        _fileController.add(file!);
      }
    }
  }

  void onFileChange(dom.Event event) {
    _fileInput = event.target as dom.FileUploadInputElement;
    file = (_fileInput!.files!.isNotEmpty) ? _fileInput!.files!.last : null;

    if (file != null) {
      _fileController.add(file!);
    }
  }
}
