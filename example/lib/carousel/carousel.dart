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
<fo-carousel>
  <fo-carousel-slide>
    <p style="text-align: center; background-color:bisque; line-height: 400%;">I automatically...</p>
  </fo-carousel-slide>
  <fo-carousel-slide>
    <p style="text-align: center; background-color:bisque; line-height: 800%;">...adjust my height...</p>
  </fo-carousel-slide>
  <fo-carousel-slide>
    <p style="text-align: center; background-color:bisque; line-height: 1600%;">..to fit my largest slide</p>
  </fo-carousel-slide>
</fo-carousel>''';
  final String htmlRadioButtons = '''
<fo-carousel [showArrowButtons]="false"
             [showRadioButtons]="true">
  <fo-carousel-slide>
    <p>You're on slide #1</p>
  </fo-carousel-slide>
  <fo-carousel-slide>
    <p>You're on slide #2</p>
  </fo-carousel-slide>
  <fo-carousel-slide>
    <p>Congratulations, you've reached slide #3</p>
  </fo-carousel-slide>
</fo-carousel>
''';
  final String htmlInterval = '''
<fo-carousel [duration]="3000"
             [showArrowButtons]="false">
  <fo-carousel-slide>
    <div style="background-color:springgreen; text-align: center; padding: 2rem;">
      <h1 style="text-align: center">#1</h1>
      <p>Plant seeds</p>
    </div>
  </fo-carousel-slide>
  <fo-carousel-slide>
    <div style="background-color:skyblue; text-align: center; padding: 2rem;">
      <h1>#2</h1>
      <p>Wait a few months</p>
    </div>
  </fo-carousel-slide>
  <fo-carousel-slide>
    <div style="background-color:plum; text-align: center; padding: 2rem;">
      <h1>#3</h1>
      <p>Sell for profit</p>
    </div>
  </fo-carousel-slide>
</fo-carousel>
''';
}
