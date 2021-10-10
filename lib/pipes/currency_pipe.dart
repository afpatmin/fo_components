import 'package:angular/angular.dart' show Pipe;

/// Add currency symbol to a value
/// "<p>{{'100' | currency:'USD'}}</p>" evaluates to "<p>$100</p>"
@Pipe('focurrency')
class FoCurrencyPipe {
  String? transform(Object value, String currency) {
    switch (currency.toUpperCase()) {
      case 'EUR':
        return '€$value';

      case 'GBP':
        return '£$value';

      case 'SEK':
        return '$value kr';

      case 'USD':
        return '\$$value';

      default:
        return '$value $currency';
    }
  }

  bool supports(Object obj) => obj is String || obj is num;
}
