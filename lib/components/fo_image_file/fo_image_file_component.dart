// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'dart:convert';
import 'dart:html' as dom;
import 'dart:typed_data';

import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_button/fo_button_component.dart';
import 'package:fo_components/components/fo_icon/fo_icon_component.dart';
import 'package:fo_components/src/components/fo_label/fo_label_component.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'fo-image-file',
    templateUrl: 'fo_image_file_component.html',
    styleUrls: ['fo_image_file_component.css'],
    directives: [
      coreDirectives,
      FoButtonComponent,
      FoIconComponent,
      FoLabelComponent
    ],
    changeDetection: ChangeDetectionStrategy.OnPush)

/// A component that loads an image file and converts it to base64 data.
/// When an image has been loaded, it's immediately displayed to the user and
/// 'sourceChanged' event fires containing the base64 data
class FoImageFileComponent implements OnDestroy {
  final String msgInvalidFile =
      Intl.message('invalid file', name: 'invalid_file');

  Map<String, String> get styles =>
      {'filter': brightnessFilter, 'background-image': 'url($source)'};

  @Input()
  String accept = 'image/jpg,image/jpeg,image/png,image/gif';

  /// Image source. Can be either a base64 encoded string, or an url
  @Input()
  String source = '';

  @Input()
  String label = 'Select an image';

  @Input()
  bool materialIcons = true;

  @Input()
  String addIcon = 'add_a_photo';

  @Input()
  String alt = '';

  @Input()
  String placeholder = '';

  @Input()
  bool disabled = false;

  /// Maximum width in pixels of the output image
  @Input()
  int maxWidth = 1024;

  /// Maximum width in pixels of the output image
  @Input()
  int maxHeight = 1024;

  /// Maximum bytesize in pixels of the output image
  @Input()
  int maxByteSize = 1024000;

  @Input()
  int brightness = 100;

  void onDelete(dom.Event e) {
    e.stopPropagation();
    if (disabled != true) {
      fileInput!.value = null;
      clearSource();
    }
  }

  @ViewChild('fileInput')
  dom.InputElement? fileInput;

  String _base64Data = '';
  bool invalidFile = false;
  int _byteSize = 0;
  int _orientation = 0;
  final dom.FileReader _metaReader = dom.FileReader();
  final dom.FileReader _reader = dom.FileReader();
  final ChangeDetectorRef _changeDetectorRef;
  final StreamController<String> _onSourceChangeController = StreamController();
  dom.FileUploadInputElement? _fileInput;
  dom.File? _file;

  FoImageFileComponent(this._changeDetectorRef) {
    _metaReader.onLoad.listen(_extractExifOrientationAndLoadImage);
    _reader.onLoad.listen(_generateScaledImage);
  }

  String get brightnessFilter => 'brightness($brightness%)';

  @Output('sourceChange')
  Stream<String> get onSourceChange => _onSourceChangeController.stream;
  void clearSource() {
    source = '';
    _onSourceChangeController.add('');
  }

  @override
  void ngOnDestroy() {
    _onSourceChangeController.close();
  }

  void onDrop(dom.MouseEvent event) {
    event.preventDefault();
    final dt = event.dataTransfer;
    try {
      if (dt.files!.isNotEmpty) _processFile(dt.files!.last);
    } on Exception catch (e) {
      invalidFile = true;
      print(e);
    }
  }

  void onFileChange(dom.Event event) {
    _fileInput = event.target as dom.FileUploadInputElement;
    try {
      if (_fileInput!.files!.isNotEmpty) _processFile(_fileInput!.files!.last);
    } on Exception catch (e) {
      invalidFile = true;
      print(e);
    }
  }

  /// Loads image only after exif orientation has been extracted
  void _extractExifOrientationAndLoadImage(dom.ProgressEvent e) {
    _orientation = 0;
    final buffer = Uint8List(e.loaded!)
      ..setRange(0, e.loaded!, _metaReader.result as Iterable<int>);

    final byteData = ByteData.view(buffer.buffer);

    /// skip first two bytes (0xFF 0xD8) indicating this is is a jpg file
    var byteOffset = 2;

    while (byteOffset <= e.loaded!) {
      /// First byte is always 0xFF and second byte (0x**) is always identifier of what comes next
      byteOffset += 1;
      final identifier = byteData.getUint8(byteOffset);
      byteOffset += 1;

      // Data ByteSize (including ByteSize info itself (+2 bytes))
      final dataByteSize = byteData.getUint16(byteOffset);
      byteOffset += 2;

      if (identifier == 225)

      /// 0xE1 - Exif Marker
      {
        final exifIdentifier = <int>[
          byteData.getUint8(byteOffset),
          byteData.getUint8(byteOffset + 1),
          byteData.getUint8(byteOffset + 2),
          byteData.getUint8(byteOffset + 3)
        ];
        final strExifIdentifier = ascii.decode(exifIdentifier);
        if (strExifIdentifier == 'Exif') {
          /// 'Exif\0\0'
          byteOffset += 6;

          final strEndian = (ascii.decode([
            byteData.getUint8(byteOffset),
            byteData.getUint8(byteOffset + 1)
          ]));
          final endian = (strEndian == 'II') ? Endian.little : Endian.big;
          byteOffset += 2;

          /// Next two bytes are Always 0x2a00 (or 0x002a for big endian)
          byteOffset += 2;

          final offsetExifToIFD = byteData.getUint32(byteOffset, endian);
          byteOffset += offsetExifToIFD - 4;

          final exifEntries = byteData.getUint16(byteOffset, endian);
          byteOffset += 2;

          for (var i = 0; i < exifEntries; i++) {
            final type = byteData.getUint16(byteOffset, endian);
            byteOffset += 2;

            /// Orientation
            if (type == 274) {
              /// data format (we know this is unsigned short
              byteOffset += 2;

              /// number of components (we know this is 1)
              byteOffset += 4;

              _orientation = byteData.getUint16(byteOffset, endian);
              byteOffset += 4;
            } else {
              byteOffset += 10;
            }

            /// 12 bytes per entry
          }
        }
        break;
      }
      byteOffset += dataByteSize - 2;
    }

    /// Done reading metadata, read actual image
    _reader.readAsDataUrl(_file!);
  }

  String? get backgroundImage =>
      source.isEmpty != false ? 'url($source)' : null;

  void _generateScaledImage(dom.ProgressEvent e) {
    final b64 = StringBuffer()..write(_reader.result.toString());
    final strB64 = b64.toString();

    if (b64.toString().contains('data:image/jpeg;base64,')) {
      while ((b64.length - 'data:image/jpeg;base64,'.length) % 4 > 0) {
        b64.write('=');
      }
    } else if (strB64.contains('data:image/jpg;base64,') ||
        strB64.contains('data:image/png;base64,') ||
        strB64.contains('data:image/gif;base64,') ||
        strB64.contains('data:image/bmp;base64,')) {
      while ((b64.length - 'data:image/jpg;base64,'.length) % 4 > 0) {
        b64.write('=');
      }
    }

    final temp = dom.ImageElement()..src = b64.toString();

    temp.onLoad.listen((_) {
      dom.CanvasElement canvas;
      final w = temp.width!;
      final h = temp.height!;

      /// make sure the image is not bigger than maxDimension x maxDimension pixels, if it is, scale down and maintain aspect ratio
      if (w > maxWidth || h > maxHeight) {
        final scaleFactor =
            (w > h) ? maxWidth.toDouble() / w : maxHeight.toDouble() / h;
        final scaledWidth = (w * scaleFactor).toInt();
        final scaledHeight = (h * scaleFactor).toInt();

        canvas = dom.CanvasElement(width: scaledWidth, height: scaledHeight);
        _transformContextExifOrientation(
            canvas, _orientation, scaledWidth, scaledHeight);
        canvas.context2D
          ..imageSmoothingEnabled = false
          ..drawImageScaledFromSource(
              temp, 0, 0, w, h, 0, 0, scaledWidth, scaledHeight);
      } else {
        canvas = dom.CanvasElement(width: w, height: h);
        //final context = canvas.context2D;
        _transformContextExifOrientation(canvas, _orientation, w, h);
        canvas.context2D
          ..imageSmoothingEnabled = false
          ..drawImage(temp, 0, 0);
      }

      /// make sure the image fileSize <= maxByteSize
      _byteSize = maxByteSize + 1;
      var quality = 0.9;
      while (_byteSize > maxByteSize && quality > 0.1) {
        source = canvas.toDataUrl(_file!.type, quality);
        quality -= 0.1;

        if (source.contains('data:${_file!.type};base64,')) {
          _base64Data = source.substring('data:${_file!.type};base64,'.length);
          _byteSize = base64.decode(_base64Data).length;
        } else {
          print('invalid src: $source');
        }
      }
      _onSourceChangeController.add(source);
      _changeDetectorRef.markForCheck();
    });
  }

  void _processFile(dom.File file) {
    _base64Data = source = '';
    invalidFile = false;
    _file = file;

    /// Verify this is .jpeg/.png/.bmp/.gif
    /// JPG file - read EXIF metadata so that we can figure out image orientation and rotate accordingly
    if (_file!.type == 'image/jpeg' || _file!.type == 'image/jpg') {
      /// EXIF specifications states metadata will always be in the first 64kb of the file, we double it just in case.
      _metaReader.readAsArrayBuffer(_file!.slice(0, 131072));
    }

    /// Any other supported format, skip metadata
    else if (_file!.type == 'image/png' ||
        _file!.type == 'image/gif' ||
        _file!.type == 'image/bmp') {
      _reader.readAsDataUrl(_file!);
    } else {
      throw Exception('Invalid file');
    }
  }

  void _transformContextExifOrientation(
      dom.CanvasElement canvas, int orientation, int width, int height) {
    canvas
      ..width = width
      ..height = height;
    canvas.context2D.setTransform(1, 0, 0, 1, 0, 0);

    switch (orientation) {
      case 1:

        /// no transform
        canvas.context2D.transform(1, 0, 0, 1, 0, 0);
        break;

      case 2:
        canvas.context2D.transform(-1, 0, 0, 1, width, 0);
        break;

      case 3:
        canvas.context2D.transform(-1, 0, 0, -1, width, height);
        break;

      case 4:
        canvas.context2D.transform(1, 0, 0, -1, 0, height);
        break;

      case 5:

        /// [5,6,7,8] has 90 degree rotation, flip canvas width/height
        canvas.width = height;
        canvas.height = width;
        canvas.context2D.transform(0, 1, 1, 0, 0, 0);
        break;

      case 6:
        canvas.width = height;
        canvas.height = width;
        canvas.context2D.transform(0, 1, -1, 0, height, 0);
        break;

      case 7:
        canvas.width = height;
        canvas.height = width;
        canvas.context2D.transform(0, -1, -1, 0, height, width);
        break;

      case 8:
        canvas.width = height;
        canvas.height = width;
        canvas.context2D.transform(0, -1, 1, 0, 0, width);
        break;

      default:
        break;
    }
  }
}
