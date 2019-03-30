import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import '../../pipes/capitalize_pipe.dart';

@Component(
    selector: 'fo-panel',
    templateUrl: 'fo_panel_component.html',
    styleUrls: ['fo_panel_component.css'],
    directives: [MaterialButtonComponent, MaterialIconComponent, NgIf],
    pipes: [CapitalizePipe])
class FoPanelComponent implements OnDestroy {
  final StreamController _visibleChangeController = StreamController<bool>();

  FoPanelComponent();

  @Input()
  String title;

  @Input()
  bool visible = true;

  @Output('visibleChange')
  Stream<bool> get visibleChange => _visibleChangeController.stream;

  void onClose() {
    _visibleChangeController.add(false);
    visible = false;
  }

  @override
  void ngOnDestroy() {
    _visibleChangeController.close();
  }
}
