import 'package:angular/angular.dart';

@Component(
  selector: 'fo-reorder-item',
  templateUrl: 'reorder_list_component.html',
  styleUrls: ['reorder_list_component.css'],
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoReorderItemComponentComponent {
  FoReorderItemComponentComponent();
}
