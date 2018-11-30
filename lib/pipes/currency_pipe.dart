import 'package:angular/di.dart' show Pipe, PipeTransform;

/// Add currency symbol to a value
/// "<p>{{'100' | currency:'USD'}}</p>" evaluates to "<p>$100</p>"
@Pipe('currency')
class CurrencyPipe implements PipeTransform {
  String transform(Object value, String currency) {
    if (value == null) return null;
    if (currency == null) return value;
    
    switch (currency.toUpperCase()) {
      case 'EUR':
        return '€$value';
        break;

      case 'GBP':
        return '£$value';
        break;

      case 'SEK':
        return '$value kr';

      case 'USD':
        return '\$$value';

      default:
        return '$value $currency';
    }
  }
}
