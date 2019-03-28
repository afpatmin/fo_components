import 'package:angular/di.dart';
import 'package:intl/intl.dart';

@Injectable()
class FoMessagesService {
  String add() => Intl.message('add', name: 'add');

  String cancel() => Intl.message('cancel', name: 'cancel');

  String confirm() => Intl.message('confirm', name: 'confirm');

  String confirm_delete_resource() =>
      Intl.message('Are you sure you want to delete this resource?',
          name: 'confirm_delete_resource');

  String download_csv() =>
      Intl.message('download .CSV file', name: 'download_csv');

  String enter_value() => Intl.message('enter a value', name: 'enter_value');

  String error_invalid_email() =>
      Intl.message('invalid email address', name: 'error_invalid email');

  String error_invalid_pattern(String pattern) =>
      Intl.message('invalid pattern, required pattern: $pattern',
          args: [pattern], name: 'error_invalid_pattern');

  String error_max_length(int maxValue) =>
      Intl.message('enter no more than $maxValue letters',
          args: [maxValue], name: 'error_max_length');

  String error_min_length(int minValue) =>
      Intl.message('enter at least $minValue letters',
          args: [minValue], name: 'error_min_length');

  String error_required() =>
      Intl.message('this field is required', name: 'error_required');

  String filter() => Intl.message('filter', name: 'filter');

  String information() => Intl.message('information', name: 'information');

  String invalid_file() => Intl.message('invalid file', name: 'invalid_file');

  String max_filesize_exceeded() =>
      Intl.message('max filesize exceeded', name: 'max_filesize_exceeded');

  String no_results_found() =>
      Intl.message('no results found', name: 'no_results_found');

  String ok() => Intl.message('ok', name: 'ok');

  String page(int howMany) => Intl.plural(howMany,
      one: 'page', other: 'pages', args: [howMany], name: 'page');

  String row(int howMany) => Intl.plural(howMany,
      one: 'row', other: 'rows', args: [howMany], name: 'row');

  String search() => Intl.message('search', name: 'search');

  String select() => Intl.message('select', name: 'select');

  String with_selected() =>
      Intl.message('with selected', name: 'with_selected');
}
