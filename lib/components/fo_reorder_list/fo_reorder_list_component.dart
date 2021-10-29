import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:dnd/dnd.dart';
import 'package:fo_components/directives/reorder_item_directive.dart';
export 'package:fo_components/directives/reorder_item_directive.dart';

@Component(
  selector: 'fo-reorder-list',
  templateUrl: 'fo_reorder_list_component.html',
  styleUrls: ['fo_reorder_list_component.css'],
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoReorderListComponent implements OnDestroy, AfterContentInit {
  final firstDropZone = dom.DivElement()..style.height = '30px';
  final lastDropZone = dom.DivElement()..style.height = '30px';
  final dom.Element _host;
  StreamSubscription<DropzoneEvent>? _itemDropSubscription;
  StreamSubscription<DropzoneEvent>? _firstDropSubscription;
  StreamSubscription<DropzoneEvent>? _lastDropSubscription;
  final StreamController<FoReorderEvent> _reorderController =
      StreamController<FoReorderEvent>.broadcast();

  @Input()
  bool disabled = false;

  @Output('reorder')
  Stream<FoReorderEvent> get onReorder => _reorderController.stream;

  late List<dom.Element> _items;

  FoReorderListComponent(this._host) {
    _firstDropSubscription = Dropzone(firstDropZone, overClass: 'fo-dragover')
        .onDrop
        .listen(_onDropOverFirst);
    _lastDropSubscription = Dropzone(lastDropZone, overClass: 'fo-dragover')
        .onDrop
        .listen(_onDropOverLast);
  }

  @ContentChildren(ReorderItemDirective)
  set items(List<ReorderItemDirective> value) {
    _items = value.map((e) => e.element).toList();

    if (_items.isNotEmpty) {
      Draggable(
        _items,
        avatarHandler: AvatarHandler.clone(),
        draggingClass: 'fo-dragging',
        draggingClassBody: 'fo-dragging-body',
      );

      _itemDropSubscription = Dropzone(_items, overClass: 'fo-dragover')
          .onDrop
          .listen(_onDropOverItem);
    }
  }

  /// Padding, in pixels to be used as the first and last dropzone
  @Input()
  set padding(int v) {
    firstDropZone.style.height = lastDropZone.style.height = '${v}px';
  }

  @override
  void ngOnDestroy() {
    _itemDropSubscription?.cancel();
    _firstDropSubscription?.cancel();
    _lastDropSubscription?.cancel();
    _reorderController.close();

    _itemDropSubscription = null;
    _firstDropSubscription = null;
    _lastDropSubscription = null;
  }

  void _onDropOverFirst(DropzoneEvent event) {
    if (!disabled) {
      _reorderController
          .add(FoReorderEvent(_items.indexOf(event.draggableElement), 0));
      _items
        ..remove(event.draggableElement)
        ..insert(0, event.draggableElement);

      _refreshView();
    }
  }

  void _onDropOverItem(DropzoneEvent event) {
    if (!disabled) {
      if (event.draggableElement != event.dropzoneElement) {
        _reorderController.add(FoReorderEvent(
            _items.indexOf(event.draggableElement),
            _items.indexOf(event.dropzoneElement)));
        _items
          ..remove(event.draggableElement)
          ..insert(
              _items.indexOf(event.dropzoneElement), event.draggableElement);
        _refreshView();
      }
    }
  }

  void _onDropOverLast(DropzoneEvent event) {
    if (!disabled) {
      _reorderController.add(FoReorderEvent(
          _items.indexOf(event.draggableElement), _items.length - 1));
      _items
        ..remove(event.draggableElement)
        ..add(event.draggableElement);

      _refreshView();
    }
  }

  void _refreshView() {
    if (_items.isNotEmpty) {
      _host.children
        ..clear()
        ..add(firstDropZone)
        ..addAll(_items)
        ..add(lastDropZone);
    }
  }

  @override
  void ngAfterContentInit() {
    _host.children
      ..insert(0, firstDropZone)
      ..add(lastDropZone);
  }
}

class FoReorderEvent {
  final int sourceIndex;
  final int destIndex;

  const FoReorderEvent(this.sourceIndex, this.destIndex);
}
