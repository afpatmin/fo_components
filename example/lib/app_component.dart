import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fo_components/pipes/capitalize_pipe.dart';

import 'button/button.template.dart' as button_comp;
import 'carousel/carousel.template.dart' as carousel_comp;
import 'data_table/data_table.template.dart' as data_table_comp;
import 'dropdown_select/dropdown_select.template.dart' as dropdown_select_comp;
import 'text_input/text_input.template.dart' as text_input_comp;

@Component(
    selector: 'app',
    templateUrl: 'app_component.html',
    styleUrls: ['app_component.css'],
    directives: [NgFor, routerDirectives],
    providers: [materialProviders, routerProvidersHash],
    pipes: [CapitalizePipe])
class AppComponent {
  AppComponent();

  final List<RouteDefinition> routes = <RouteDefinition>[
    RouteDefinition(
        routePath: RoutePath(path: 'FoButtonComponent', useAsDefault: true),
        component: button_comp.ButtonNgFactory),
    RouteDefinition(
        path: 'FoCarouselComponent',
        component: carousel_comp.CarouselNgFactory),
    RouteDefinition(
        path: 'FoDataTableComponent',
        component: data_table_comp.DataTableNgFactory),
    RouteDefinition(
        path: 'FoDropdownSelectComponent',
        component: dropdown_select_comp.DropdownSelectNgFactory),
    RouteDefinition(
        path: 'FoTextInputComponent',
        component: text_input_comp.TextInputNgFactory)
  ];
}