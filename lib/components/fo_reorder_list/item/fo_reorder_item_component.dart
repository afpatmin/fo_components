import 'package:angular/angular.dart';

@Component(
  selector: 'fo-reorder-item',
  templateUrl: 'fo_reorder_item_component.html',
  styleUrls: ['fo_reorder_item_component.css'],
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoReorderItemComponent {
  FoReorderItemComponent();
}
