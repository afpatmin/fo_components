import 'package:angular/angular.dart';
import 'dart:math' as math;

@Component(
  selector: 'fo-progress-bar',
  templateUrl: 'fo_progress_bar_component.html',
  styleUrls: ['fo_progress_bar_component.css'],
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoProgressBarComponent {
  @Input()
  set progress(int v) {
    progressWidth = '${math.min(v.abs(), 100)}%';
  }

  String progressWidth = '0';
}
