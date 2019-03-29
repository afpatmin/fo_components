import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fo_components/pipes/capitalize_pipe.dart';

import 'button/button.template.dart' as button_comp;
import 'carousel/carousel.template.dart' as carousel_comp;

@Component(
    selector: 'app',
    templateUrl: 'app_component.html',
    styleUrls: ['app_component.css'],
    directives: [NgFor, routerDirectives],
    providers: [routerProvidersHash],
    pipes: [CapitalizePipe])
class AppComponent {
  AppComponent();

  final routes = <RouteDefinition>[
    RouteDefinition(
        routePath: RoutePath(path: 'FoButtonComponent', useAsDefault: true),
        component: button_comp.ButtonNgFactory),
    RouteDefinition(
        path: 'FoCarouselComponent', component: carousel_comp.CarouselNgFactory)
  ];
}
