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
  StreamSubscription<DropzoneEvent>? _itemDropSubscription;
  final StreamController<FoReorderEvent> _reorderController =
      StreamController<FoReorderEvent>.broadcast();

  @Input()
  bool disabled = false;

  late List<dom.Element> _items;

  FoReorderListComponent(this._host);

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

  @Output('reorder')
  Stream<FoReorderEvent> get onReorder => _reorderController.stream;

  @override
  void ngOnDestroy() {
    _itemDropSubscription?.cancel();
    _reorderController.close();
    _itemDropSubscription = null;
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

  void _refreshView() {
    if (_items.isNotEmpty) {
      _host.children
        ..clear()
        ..addAll(_items);
    }
  }
}
