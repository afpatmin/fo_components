import 'package:angular_forms/angular_forms.dart';
import 'package:intl/intl.dart';

class FoValidators {
  static ValidatorFn required([String message]) => (control) {
        if (control?.value == null || control.value.toString().isEmpty) {
          return message == null
              ? {'error': Intl.message('Enter a value')}
              : {'error': message};
        } else
          return null;
      };

  static Map<String, String> alpha(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[a-zA-ZåäöÅÄÖ ]').allMatches(control.value).length !=
        control.value.length) {
      return {'error': Intl.message('Enter alphabet characters only')};
    } else
      return null;
  }

  static Map<String, String> alphaEn(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[a-zA-Z ]').allMatches(control.value).length !=
        control.value.length) {
      return {'error': Intl.message('Enter alphabet characters only')};
    } else
      return null;
  }

  static Map<String, String> alphaNumeric(AbstractControl control) {
    if ((required())(control) != null) return null;

    final value = control.value;
    final r = new RegExp(r'[a-zA-ZåäöÅÄÖ0-9 ]');
    if (r.allMatches(value).length != value.length) {
      return {'error': Intl.message('Enter alphanumeric characters only')};
    } else
      return null;
  }

  static Map<String, String> email(AbstractControl control) {
    if ((required())(control) != null) return null;

    final r = new RegExp(r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)');
    if (r.stringMatch(control.value) != control.value) {
      return {'error': Intl.message('Invalid email')};
    } else
      return null;
  }

  static Map<String, String> integer(AbstractControl control) {
    if ((required())(control) != null)
      return null;
    else if (control.value == null)
      return null;
    else if (control.value is int)
      return null;
    else {
      try {
        int.parse(control.value);
      } on FormatException {
        return {'error': Intl.message('Enter integer values only')};
      }
      return null;
    }
  }

  static Map<String, String> linkedInId(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[a-z0-9åäö\-\\/]{5,50}').stringMatch(control.value) !=
        control.value) {
      return {'error': Intl.message('Invalid LinkedIn id')};
    } else
      return null;
  }

  static Map<String, String> lowercase(AbstractControl control) {
    if ((required())(control) != null) return null;

    final value = control.value;
    if (value == value.toLowerCase())
      return null;
    else {
      return {'error': Intl.message('Enter lowercase letters only')};
    }
  }

  static ValidatorFn minLength(num minLength) => (control) {
        if (Validators.required(control) != null) return null;

        final v = control.value;
        if (v.length < minLength) {
          return {
            'minlength': {
              'requiredLength': minLength,
              'actualLength': v.length
            },
            'error': Intl.message('Enter at least $minLength characters')
          };
        }
        return null;
      };

  static Map<String, String> noSpaces(AbstractControl control) {
    if ((required())(control) != null) return null;
    final v = control.value.toString();
    if (v.contains(' ')) {
      return {'error': Intl.message('Enter a value with no spaces')};
    }
    return null;
  }

  static Map<String, String> numeric(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (control.value is num)
      return null;
    else {
      try {
        num.parse(control.value);
      } on FormatException {
        return {'error': Intl.message('Enter a numeric value')};
      }
      return null;
    }
  }

  static Map<String, String> phoneNumber(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[+][0-9]{2}[1-9][0-9\- ]{6,32}')
            .stringMatch(control.value) !=
        control.value) {
      return {
        'error': Intl.message(
            'Enter a valid phone number including country code (+xxxxxxxx)')
      };
    } else
      return null;
  }

  static Map<String, String> phoneNumberWithoutCountryCode(
      AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[1-9][0-9\- ]{6,32}').stringMatch(control.value) !=
        control.value) {
      return {
        'error': Intl.message(
            'Enter a valid phone number without country code, and without the leading zero')
      };
    } else
      return null;
  }

  static Map<String, String> swedishCellphoneNumber(AbstractControl control) {
    if (required()(control) != null) return null;
    if (new RegExp('07[0-9]{8}').stringMatch(control.value) != control.value) {
      return {
        'error': Intl.message(
            'Enter a valid swedish cellphone number without spaces (07xxxxxxxx)')
      };
    } else
      return null;
  }

  static Map<String, String> swedishSocialSecurityNumber(
      AbstractControl control) {
    if ((required())(control) != null) return null;

    final r = new RegExp(
        '(19|20)[0-9]{2,2}(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-2])[0-9]{4,4}');
    if (r.stringMatch(control.value) != control.value) {
      return {
        'error': Intl.message(
            'Enter a valid swedish social security number (yyyymmddxxxx)')
      };
    } else
      return null;
  }

  static Map<String, String> url(AbstractControl control) {
    if ((required())(control) != null) return null;
    final r = new RegExp(
        r'https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_+.~#?&/=]*)');
    if (r.stringMatch(control.value) != control.value) {
      return {'error': Intl.message('Invalid URL')};
    } else
      return null;
  }

  static Map<String, String> noWhiteSpace(AbstractControl control) {
    if ((required())(control) != null) return null;
    if (control.value.toString().contains(' ')) {
      return {'error': Intl.message('Enter a value without spaces')};
    } else
      return null;
  }

  static Map<String, String> youtubeId(AbstractControl control) {
    if ((required())(control) != null) return null;
    if (new RegExp(r'[a-zA-Z0-9_-]{11}').stringMatch(control.value) !=
        control.value) {
      return {'error': Intl.message('Invalid Youtube id')};
    } else
      return null;
  }
}
