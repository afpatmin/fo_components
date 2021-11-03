import 'dart:async';

import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_icon/fo_icon_component.dart';

@Component(
  selector: 'fo-chip',
  templateUrl: 'fo_chip_component.html',
  styleUrls: ['fo_chip_component.css'],
  directives: [coreDirectives, FoIconComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoChipComponent {
  @Input()
  List<String> chipsList = ['Chip'];

  final StreamController<List<String>> closeController =
      StreamController<List<String>>();

  @Output('close')
  Stream<List<String>> get close => closeController.stream;

  //end of experiment

}
