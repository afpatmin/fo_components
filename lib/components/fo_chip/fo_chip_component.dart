import 'dart:async';

import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_icon/fo_icon_component.dart';

/// A chip component that can be used for tagging something with labels
@Component(
  selector: 'fo-chip',
  templateUrl: 'fo_chip_component.html',
  styleUrls: ['fo_chip_component.css'],
  directives: [coreDirectives, FoIconComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoChipComponent {
  @Input()
  String name = '';

  final StreamController<String> closeController = StreamController<String>();

  @Output('close')
  Stream<String> get close => closeController.stream;
}
