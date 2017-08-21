// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'dart:convert' show ASCII, BASE64;
import 'dart:html' as dom;
import 'dart:typed_data' show ByteData, Endianness, Uint8List;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'fo-image-file',
    templateUrl: 'fo_image_file_component.html',
    styleUrls: const ['fo_image_file_component.css'],
    directives: const [GlyphComponent, MaterialButtonComponent],
    providers: const [],
    preserveWhitespace: false)

class FoImageFileComponent implements OnDestroy
{
  FoImageFileComponent()
  {
    _metaReader.onLoad.listen(_extractExifOrientationAndLoadImage);
    _reader.onLoad.listen(_generateScaledImage);
  }

  void ngOnDestroy()
  {
    _onSourceChangeController.close();
  }

  void onDrop(dom.MouseEvent event)
  {
    event.preventDefault();
    dom.DataTransfer dt = event.dataTransfer;
    try
    {
      if (dt.files.isNotEmpty) _processFile(dt.files.last);
    }
    catch (e)
    {
      invalidFile = true;
      print(e);
    }
  }

  void onFileChange(dynamic event)
  {
    _fileInput = event.target;
    try
    {
      if (_fileInput.files.isNotEmpty) _processFile(_fileInput.files.last);
    }
    catch (e)
    {
      invalidFile = true;
      print(e);
    }
  }

  void _processFile(dom.File file)
  {
    _base64Data = source = null;
    invalidFile = false;
    _file = file;
    /// Verify this is .jpeg/.png/.bmp/.gif
    /// JPG file - read EXIF metadata so that we can figure out image orientation and rotate accordingly
    if (_file.type == "image/jpeg" || _file.type == "image/jpg")
    {
      /// EXIF specifications states metadata will always be in the first 64kb of the file, we double it just in case.
      _metaReader.readAsArrayBuffer(_file.slice(0, 131072));
    }
    /// Any other supported format, skip metadata
    else if (_file.type == "image/png" || _file.type == "image/gif" || _file.type == "image/bmp") _reader.readAsDataUrl(_file);
    else throw new Exception("Invalid file");
  }

  void clearSource()
  {
    source = "";
    _onSourceChangeController.add("");
  }

  @Input('source')
  String source = "";

  @Input('label')
  String label = "Image";

  @Input('alt')
  String alt = "";

  @Input('maxWidth')
  int maxWidth = 1024;

  @Input('maxHeight')
  int maxHeight = 1024;

  @Input('maxByteSize')
  int maxByteSize = 1024000;

  @Output('sourceChange')
  Stream<String> get onSourceChange => _onSourceChangeController.stream;

  /// Loads image only after exif orientation has been extracted
  void _extractExifOrientationAndLoadImage(dom.ProgressEvent e)
  {
    _orientation = 0;
    Uint8List buffer = new Uint8List(e.loaded); // 0-255
    buffer.setRange(0, e.loaded, _metaReader.result);

    ByteData byteData = new ByteData.view(buffer.buffer);

    /// skip first two bytes (0xFF 0xD8) indicating this is is a jpg file
    int byteOffset = 2;

    while (byteOffset <= e.loaded)
    {
      /// First byte is always 0xFF and second byte (0x**) is always identifier of what comes next
      byteOffset += 1;
      int identifier = byteData.getUint8(byteOffset);
      byteOffset += 1;

      // Data ByteSize (including ByteSize info itself (+2 bytes))
      int dataByteSize = byteData.getUint16(byteOffset);
      byteOffset += 2;

      if (identifier == 225) /// 0xE1 - Exif Marker
      {
        List<int> exifIdentifier = [byteData.getUint8(byteOffset), byteData.getUint8(byteOffset+1), byteData.getUint8(byteOffset+2), byteData.getUint8(byteOffset+3)];
        String strExifIdentifier = ASCII.decode(exifIdentifier);
        if (strExifIdentifier == "Exif")
        {
          /// "Exif\0\0"
          byteOffset += 6;

          /// TIFF HEADER
          /// Endianess
          String strEndian = (ASCII.decode([byteData.getUint8(byteOffset), byteData.getUint8(byteOffset + 1)]));
          Endianness endian = (strEndian == "II") ? Endianness.LITTLE_ENDIAN : Endianness.BIG_ENDIAN;
          byteOffset += 2;

          /// Next two bytes are Always 0x2a00 (or 0x002a for big endian)
          byteOffset += 2;

          /// Offset to the first IDF (from exifStart)
          int offsetExifToIFD = byteData.getUint32(byteOffset, endian);
          byteOffset += offsetExifToIFD - 4;

          /// Number of entries in this IFD
          int exifEntries = byteData.getUint16(byteOffset, endian);
          byteOffset += 2;

          for (int i = 0; i < exifEntries; i++)
          {
            /// Type
            int type = byteData.getUint16(byteOffset, endian);
            byteOffset += 2;

            /// Orientation
            if (type == 274)
            {
              /// data format (we know this is unsigned short
              byteOffset += 2;

              /// number of components (we know this is 1)
              byteOffset += 4;

              _orientation = byteData.getUint16(byteOffset, endian);
              byteOffset += 4;
            }
            else byteOffset += 10; /// 12 bytes per entry
          }
        }
        break;
      }
      byteOffset += dataByteSize - 2;
    }

    /// Done reading metadata, read actual image
    _reader.readAsDataUrl(_file);
  }

  void _generateScaledImage(dom.ProgressEvent e)
  {
    /// Pad the base64 encoded data to become divisible by 4 to conform with iOS standards.
    String base64 = _reader.result.toString();
    if (base64.contains("data:image/jpeg;base64,"))
    {
      while ((base64.length - "data:image/jpeg;base64,".length) % 4 > 0) { base64 += '='; }
    }
    else if (base64.contains("data:image/jpg;base64,") || base64.contains("data:image/png;base64,") || base64.contains("data:image/gif;base64,") || base64.contains("data:image/bmp;base64,"))
    {
      while ((base64.length - "data:image/jpg;base64,".length) % 4 > 0) { base64 += '='; }
    }

    /// Scale down the image
    dom.ImageElement temp = new dom.ImageElement();
    temp.src = base64;

    temp.onLoad.listen((_)
    {
      dom.CanvasElement canvas = null;

      /// make sure the image is not bigger than maxDimension x maxDimension pixels, if it is, scale down and maintain aspect ratio
      if (temp.width > maxWidth || temp.height > maxHeight)
      {
        double scaleFactor = (temp.width > temp.height) ? maxWidth.toDouble() / temp.width : maxHeight.toDouble() / temp.height;
        int scaledWidth = (temp.width * scaleFactor).toInt();
        int scaledHeight = (temp.height * scaleFactor).toInt();

        canvas = new dom.CanvasElement(width: scaledWidth, height: scaledHeight);
        dom.CanvasRenderingContext2D context = canvas.context2D;
        _transformContextExifOrientation(canvas, _orientation, scaledWidth, scaledHeight);
        context.imageSmoothingEnabled = false;
        context.drawImageScaledFromSource(temp, 0, 0, temp.width, temp.height, 0, 0, scaledWidth, scaledHeight);
      }
      else
      {
        canvas = new dom.CanvasElement(width: temp.width, height: temp.height);
        dom.CanvasRenderingContext2D context = canvas.context2D;
        _transformContextExifOrientation(canvas, _orientation, temp.width, temp.height);
        context.imageSmoothingEnabled = false;
        context.drawImage(temp, 0, 0);
      }

      /// make sure the image fileSize <= maxByteSize
      _byteSize = maxByteSize + 1;
      double quality = 0.9;
      while (_byteSize > maxByteSize && quality > 0.1)
      {
        source = canvas.toDataUrl(_file.type, quality);
        quality -= 0.1;

        if (source.contains("data:${_file.type};base64,"))
        {
          _base64Data = source.substring("data:${_file.type};base64,".length);
          _byteSize = BASE64.decode(_base64Data).length;
        }
        else print("invalid src: $source");
      }
      _onSourceChangeController.add(source);
    });
  }

  void _transformContextExifOrientation(dom.CanvasElement canvas, int orientation, int width, int height)
  {
    dom.CanvasRenderingContext2D context = canvas.context2D;

    canvas.width = width;
    canvas.height = height;
    context.setTransform(1, 0, 0, 1, 0, 0);

    switch (orientation)
    {
      case 1: /// no transform
        context.transform(1, 0, 0, 1, 0, 0);
        break;

      case 2:
        context.transform(-1, 0, 0, 1, width, 0);
        break;

      case 3:
        context.transform(-1, 0, 0, -1, width, height);
        break;

      case 4:
        context.transform(1, 0, 0, -1, 0, height);
        break;

      case 5: /// [5,6,7,8] has 90 degree rotation, flip canvas width/height
        canvas.width = height;
        canvas.height = width;
        context.transform(0, 1, 1, 0, 0, 0);
        break;

      case 6:
        canvas.width = height;
        canvas.height = width;
        context.transform(0, 1, -1, 0, height, 0);
        break;

      case 7:
        canvas.width = height;
        canvas.height = width;
        context.transform(0, -1, -1, 0, height, width);
        break;

      case 8:
        canvas.width = height;
        canvas.height = width;
        context.transform(0, -1, 1, 0, 0, width);
        break;

      default:
        break;
    }
  }

  String _base64Data = "";
  bool invalidFile = false;
  int _byteSize;
  int _orientation = 0;
  final dom.FileReader _metaReader = new dom.FileReader();
  final dom.FileReader _reader = new dom.FileReader();
  final StreamController<String> _onSourceChangeController = new StreamController();
  dom.FileUploadInputElement _fileInput;
  dom.File _file;

  @Input('invalidFileMessage')
  String invalidFileMessage = "Invalid file";
}


