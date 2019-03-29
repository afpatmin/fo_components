import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_carousel/fo_carousel_component.dart';
import 'package:fo_components/components/fo_carousel/fo_carousel_slide_component.dart';
import '../component_info/component_info.dart';
import '../section/section.dart';

@Component(selector: 'carousel', templateUrl: 'carousel.html', directives: [
  ComponentInfo,
  FoCarouselComponent,
  FoCarouselSlideComponent,
  Section
])
class Carousel {
  final String htmlDefault = '''  
<p> CONTENT HERE </p>''';
}
