import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:dnd/dnd.dart';
import 'package:fo_components/directives/reorder_item_directive.dart';

@Component(
  selector: 'fo-reorder-list',
  templateUrl: 'fo_reorder_list_component.html',
  styleUrls: ['fo_reorder_list_component.css'],
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoReorderListComponent implements OnDestroy {
  final firstDropZone = dom.DivElement()..className = 'extraDropZone';
  final lastDropZone = dom.DivElement()..className = 'extraDropZone';
  StreamSubscription<DropzoneEvent>? _itemDropSubscription;
  StreamSubscription<DropzoneEvent>? _firstDropSubscription;
  StreamSubscription<DropzoneEvent>? _lastDropSubscription;

  late List<dom.Element> _items;

  FoReorderListComponent() {
    _firstDropSubscription =
        Dropzone(firstDropZone).onDrop.listen(_onDropOverFirst);
    _lastDropSubscription =
        Dropzone(lastDropZone).onDrop.listen(_onDropOverLast);
  }

  @ContentChildren(ReorderItemDirective)
  set items(List<ReorderItemDirective> value) {
    _items = value.map((e) => e.element).toList();

    if (_items.isNotEmpty) {
      final parent = _items.first.parent!;

      parent.children
        ..insert(0, firstDropZone)
        ..add(lastDropZone);

      Draggable(_items, avatarHandler: AvatarHandler.clone());

      _itemDropSubscription = Dropzone(_items).onDrop.listen(_onDropOverItem);
    }
  }

  @override
  void ngOnDestroy() {
    _itemDropSubscription?.cancel();
    _firstDropSubscription?.cancel();
    _lastDropSubscription?.cancel();

    _itemDropSubscription = null;
    _firstDropSubscription = null;
    _lastDropSubscription = null;
  }

  void _onDropOverFirst(DropzoneEvent event) {
    _items
      ..remove(event.draggableElement)
      ..insert(0, event.draggableElement);
    _refreshView();
  }

  void _onDropOverItem(DropzoneEvent event) {
    _items
      ..remove(event.draggableElement)
      ..insert(_items.indexOf(event.dropzoneElement), event.draggableElement);
    _refreshView();
  }

  void _onDropOverLast(DropzoneEvent event) {
    _items
      ..remove(event.draggableElement)
      ..add(event.draggableElement);
    _refreshView();
  }

  void _refreshView() {
    if (_items.isNotEmpty) {
      _items.first.parent!.children
        ..clear()
        ..add(firstDropZone)
        ..addAll(_items)
        ..add(lastDropZone);
    }
  }
}
