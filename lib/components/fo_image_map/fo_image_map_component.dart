// Copyright (c) 2017, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_model/fo_model.dart';
import '../../pipes/phrase_pipe.dart';
import '../fo_multi_select/fo_multi_select_component.dart';

@Component(
    selector: 'fo-image-map',
    styleUrls: const ['fo_image_map_component.css'],
    templateUrl: 'fo_image_map_component.html',
    directives: const [
      coreDirectives,
      materialDirectives,
      FoMultiSelectComponent
    ],
    pipes: const [PhrasePipe],
    visibility: Visibility.local,
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoImageMapComponent implements OnChanges, OnDestroy {
  FoImageMapComponent();

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('selectedIds')) {
      for (final zone in zones) {
        zone.marked = selectedIds.contains(zone.id);
      }
    }
  }

  @override
  void ngOnDestroy() {
    _onSelectedIdsChangeController.close();
  }

  void onClick(FoZoneModel zone) {
    /*
    zone.marked = !zone.marked;
    selectedIds = zones.where((z) => z.marked).map((model) => model.id).toList(growable: false);
    _onSelectedIdsChangeController.add(selectedIds);
    */
  }

  void onSelectionChange(List<String> selectedIds) {
    this.selectedIds = selectedIds;

    for (final shape in zones) {
      shape.marked = selectedIds.contains(shape.id);
    }

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
  FoZoneModel(this._shapes, String id, this.label) {
    super.id = id;
  }

  @override Map<String, dynamic> toJson() => {'id':id, 'label':label, 'shapes':_shapes.length};

  @override
  String toString() => label;

  List<dynamic> get shapes => _shapes;
  Iterable<FoShapeEllipse> get ellipses => _shapes.where((s) => s.type == 'ellipse');
  Iterable<FoShapeRectangle> get rectangles =>
      _shapes.where((s) => s.type == 'rectangle');
  Iterable<FoShapePolygon> get polygons => _shapes.where((s) => s.type == 'polygon');

  bool marked = false;
  final String label;
  final List<dynamic> _shapes;
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
