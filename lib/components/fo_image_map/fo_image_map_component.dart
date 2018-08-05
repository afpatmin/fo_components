// Copyright (c) 2017, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:fo_model/fo_model.dart';
import '../fo_multi_select/fo_multi_select_component.dart';

@Component(
    selector: 'fo-image-map',
    styleUrls: const ['fo_image_map_component.css'],
    templateUrl: 'fo_image_map_component.html',
    directives: const [
      NgFor,
      NgIf,            
      FoMultiSelectComponent
    ],
    pipes: const [],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoImageMapComponent implements OnDestroy {
  FoImageMapComponent();

  @override
  void ngOnDestroy() {
    _onSelectedIdsChangeController.close();
  }

  void onSelectionChange(List<String> selectedIds) {
    _onSelectedIdsChangeController.add(selectedIds);
  }

  final StreamController<List<String>> _onSelectedIdsChangeController =
      new StreamController();

  @Input()
  String label = 'select';

  @Input()
  Iterable<FoZoneModel> zones = [];

  @Input()
  String src = '';

  @Input()
  List<String> selectedIds = [];

  @Input()
  bool showSelector = true;

  @Output('selectedIdsChange')
  Stream<List<String>> get onSelectedIdsChangeOutput =>
      _onSelectedIdsChangeController.stream;
}

class FoZoneModel extends FoModel {
  FoZoneModel(List<FoShape> shapes, String id, this.label) {
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

  @override
  Map<String, dynamic> toJson() => {'id': id, 'label': label};

  @override
  String toString() => label;

  final String label;

  final List<FoShapeEllipse> ellipses = [];
  final List<FoShapeRectangle> rectangles = [];
  final List<FoShapePolygon> polygons = [];
}

abstract class FoShape {
  FoShape(this._x, this._y, this.type, this.roundedCorners, this.transform);

  String get x => '$_x';
  String get y => '$_y';

  final int _x;
  final int _y;

  final String type;
  final bool roundedCorners;
  final String transform;
}

class FoShapeEllipse extends FoShape {
  FoShapeEllipse(int x, int y, this._rx, this._ry)
      : super(x, y, 'ellipse', false, '');

  String get rx => '$_rx';
  String get ry => '$_ry';

  final int _rx;
  final int _ry;
}

class FoShapePolygon extends FoShape {
  FoShapePolygon(this._points,
      {bool roundedCorners = true, String transform = ''})
      : super(null, null, 'polygon', roundedCorners, transform);

  String get points => _points.map((point) => point.toString()).join(' ');

  final List<FoShapePoint> _points;
}

class FoShapePoint {
  FoShapePoint(this.x, this.y);

  @override
  String toString() => '$x,$y';

  final int x;
  final int y;
}

class FoShapeRectangle extends FoShape {
  FoShapeRectangle(int x, int y, this._width, this._height,
      {bool roundedCorners = true, String transform = ''})
      : super(x, y, 'rectangle', roundedCorners, transform);

  String get width => '$_width';
  String get height => '$_height';

  final int _width;
  final int _height;
}
