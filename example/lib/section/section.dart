import 'package:angular/angular.dart';
import 'package:angular/security.dart';

@Component(
    selector: 'section',
    templateUrl: 'section.html',
    styleUrls: ['section.css'],
    directives: [NgIf, SafeInnerHtmlDirective])
class Section implements OnInit {
  @Input()
  String label;

  @Input()
  String html;

  @Input()
  String notes;

  SafeHtml notesHtml;

  final DomSanitizationService _domSanitizationService;

  Section(this._domSanitizationService);

  @override
  void ngOnInit() {
    if (notes != null) {
      notesHtml = _domSanitizationService.bypassSecurityTrustHtml(notes);
    }
  }
}
