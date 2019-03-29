import 'package:angular/angular.dart';
import 'package:angular/security.dart';
import 'package:angular_components/material_icon/material_icon.dart';

@Component(
    selector: 'component-info',
    templateUrl: 'component_info.html',
    styleUrls: ['component_info.css'],
    directives: [MaterialIconComponent],
    changeDetection: ChangeDetectionStrategy.OnPush)
class ComponentInfo implements OnInit {
  final DomSanitizationService _domSanitizationService;

  @Input()
  String name;

  @Input()
  String description;

  @Input()
  String source;

  SafeUrl sourceUrl;

  ComponentInfo(this._domSanitizationService);

  @override
  void ngOnInit() {
    if (source != null) {
      sourceUrl = _domSanitizationService.bypassSecurityTrustUrl(source);
    }
  }
}
