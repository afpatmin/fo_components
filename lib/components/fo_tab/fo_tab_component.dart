import 'package:angular/angular.dart';

@Component(
  selector: 'fo-tab',
  templateUrl: 'fo_tab_component.html',
  styleUrls: const ['fo_tab_component.css'],
  directives: const [NgIf],    
 // changeDetection: ChangeDetectionStrategy.OnPush
)
class FoTabComponent {
  FoTabComponent();

  bool active = false;  

  @Input()
  String label;

  @Input()
  String labelColor = '#333';

  @Input()
  String backgroundColor = '#888';
}