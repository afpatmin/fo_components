// Copyright (c) 2017, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';

import '../fo_dropdown_list/fo_dropdown_option.dart';
import '../fo_dropdown_select_multi/fo_dropdown_select_multi_component.dart';

@Component(
    selector: 'fo-image-map',
    styleUrls: ['fo_image_map_component.css'],
    templateUrl: 'fo_image_map_component.html',
    directives: [NgFor, NgIf, FoDropdownSelectMultiComponent])
class FoImageMapComponent implements AfterViewInit, OnDestroy {
  final StreamController<List<String>> _onSelectedIdsChangeController =
      StreamController();

  @Input()
  String label = 'select';

  @Input()
  Map<String, List<FoZoneModel>> zones = {};

  /// A valid image url
  @Input()
  String src = '';

  @Input()
  bool disabled = false;

  @Input()
  List<Object> selectedIds = [];

  @Input()
  bool showSelector = true;

  @ViewChild('image')
  html.ImageElement image;

  String viewBox;

  FoImageMapComponent();

  @Output('selectedIdsChange')
  Stream<List<String>> get onSelectedIdsChangeOutput =>
      _onSelectedIdsChangeController.stream;

  @override
  void ngOnDestroy() {
    _onSelectedIdsChangeController.close();
  }

  void onSelectionChange(List<Object> ids) {
    selectedIds = ids.cast<String>();
    _onSelectedIdsChangeController.add(selectedIds);
  }

  @override
  void ngAfterViewInit() {
    image.onLoad.listen((_) {
      final rect = image.getBoundingClientRect();
      viewBox = '0 0 ${rect.width} ${rect.height}';
    });
  }
}

abstract class FoShape {
  final int _x;
  final int _y;

  /// Can be either rectangle, polygon or ellipse
  final String type;

  final bool roundedCorners;

  /// CSS transform
  final String transform;

  FoShape(this._x, this._y, this.type, this.roundedCorners, this.transform);
  String get x => '$_x';
  String get y => '$_y';
}

class FoShapeEllipse extends FoShape {
  final int _rx;

  final int _ry;
  FoShapeEllipse(int x, int y, this._rx, this._ry)
      : super(x, y, 'ellipse', false, '');

  String get rx => '$_rx';
  String get ry => '$_ry';
}

class FoShapePoint {
  final int x;

  final int y;

  FoShapePoint(this.x, this.y);
  @override
  String toString() => '$x,$y';
}

class FoShapePolygon extends FoShape {
  final List<FoShapePoint> _points;

  FoShapePolygon(this._points,
      {bool roundedCorners = true, String transform = ''})
      : super(null, null, 'polygon', roundedCorners, transform);

  String get points => _points.map((point) => point.toString()).join(' ');
}

class FoShapeRectangle extends FoShape {
  final int _width;

  final int _height;
  FoShapeRectangle(int x, int y, this._width, this._height,
      {bool roundedCorners = true, String transform = ''})
      : super(x, y, 'rectangle', roundedCorners, transform);

  String get height => '$_height';
  String get width => '$_width';
}

class FoZoneModel extends FoDropdownOption {
  final List<FoShapeEllipse> ellipses = [];

  final List<FoShapeRectangle> rectangles = [];

  final List<FoShapePolygon> polygons = [];

  FoZoneModel(List<FoShape> shapes, String id, String label) {
    super.label = label;
    for (final shp in shapes) {
      switch (shp.type) {
        case 'ellipse':
          ellipses.add(shp);
          break;

        case 'rectangle':
          rectangles.add(shp);
          break;

        case 'polygon':
          polygons.add(shp);
          break;

        default:
          break;
      }
    }

    super.id = id;
  }

  Map<String, dynamic> toJson() => {'id': id, 'label': label};

  @override
  String toString() => label;
}
