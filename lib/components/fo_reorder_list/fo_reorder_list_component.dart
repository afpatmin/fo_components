import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:dnd/dnd.dart';
import 'package:fo_components/directives/reorder_item_directive.dart';

export 'package:fo_components/directives/reorder_item_directive.dart';

class FoReorderEvent {
  final int sourceIndex;
  final int destIndex;

  const FoReorderEvent(this.sourceIndex, this.destIndex);
}

@Component(
  selector: 'fo-reorder-list',
  templateUrl: 'fo_reorder_list_component.html',
  styleUrls: ['fo_reorder_list_component.css'],
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoReorderListComponent implements OnDestroy {
  final dom.Element _host;

  final StreamController<FoReorderEvent> _reorderController =
      StreamController<FoReorderEvent>.broadcast();

  @Input()
  bool disabled = false;

  late List<dom.Element> _items;
  bool _internallyDisabled = false;

  Draggable? _draggable;
  Dropzone? _dropzones;

  FoReorderListComponent(this._host);

  @ContentChildren(ReorderItemDirective)
  set items(List<ReorderItemDirective> value) {
    _items = value.map((e) => e.element).toList();

    if (_items.isNotEmpty) {
      _draggable?.destroy();
      _draggable = Draggable(
        _items,
        avatarHandler: AvatarHandler.clone(),
        draggingClass: 'fo-dragging',
        draggingClassBody: 'fo-dragging-body',
      );
      _dropzones?.destroy();
      _dropzones = Dropzone(_items, overClass: 'fo-dragover')
        ..onDrop.listen(_onDropOverItem);
    }
  }

  @Output('reorder')
  Stream<FoReorderEvent> get onReorder => _reorderController.stream;

  @override
  void ngOnDestroy() {
    _draggable?.destroy();
    _dropzones?.destroy();
    _reorderController.close();
  }

  Future<void> _onDropOverItem(DropzoneEvent event) async {
    if (!disabled && !_internallyDisabled) {
      if (event.draggableElement != event.dropzoneElement) {
        var dropIndex = _items.indexOf(event.dropzoneElement);
        if (dropIndex < 0) {
          dropIndex = _items.length - 1;
        }

        _internallyDisabled = true;
        _reorderController.add(
            FoReorderEvent(_items.indexOf(event.draggableElement), dropIndex));
        _items
          ..remove(event.draggableElement)
          ..insert(dropIndex, event.draggableElement);
        _refreshView();
        await Future<void>.delayed(const Duration(milliseconds: 200));
        _internallyDisabled = false;
      }
    }
  }

  void _refreshView() {
    if (_items.isNotEmpty) {
      _host.children
        ..clear()
        ..addAll(_items);
    }
  }
}
