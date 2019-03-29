import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_button/fo_button_component.dart';
import '../component_info/component_info.dart';
import '../section/section.dart';

@Component(
    selector: 'fo-button',
    templateUrl: 'button.html',
    directives: [ComponentInfo, FoButtonComponent, Section])
class Button {
  final String htmlDefault = '''  
<fo-button label="Click me"
           (trigger)="counter = counter + 1">
</fo-button>
<p> The button has been triggered {{counter}} times </p>''';

  final String htmlDisabled = '''
<fo-button [disabled]="true"
           label="I'm sorry, Dave. I'm afraid I can't do that.">
</fo-button>''';

  final String htmlAttributes = '''
<p>
  <fo-button clearSize
             label="clearSize"></fo-button>
</p>
<p>
  <fo-button dense
             white
             fullWidth
             label="dense, white, fullWidth"></fo-button>
</p>
<p>
  <fo-button label="yes"
             noRightBorder></fo-button>
  <fo-button label="no"
             noLeftBorder></fo-button>
</p>''';

  final String htmlIcons = '''
<span>
  <fo-button icon="chat"></fo-button>
</span>
<span>
  <fo-button label="Cancel "
             icon="cancel">
  </fo-button>
</span>''';

  Button();

  int counter = 0;
}
