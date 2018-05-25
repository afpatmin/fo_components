import 'package:angular_forms/angular_forms.dart';
import '../services/phrase_service.dart';

class FoValidators {
  static ValidatorFn required([String errorPhrase = 'enter_a_value']) =>
      (control) {
        if (control?.value == null || control.value.toString().isEmpty) {
          final ps = new PhraseService();
          return {'error': ps.get(errorPhrase)};
        } else
          return null;
      };

  static Map<String, String> alpha(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[a-zA-ZåäöÅÄÖ ]').allMatches(control.value).length !=
        control.value.length) {
      final ps = new PhraseService();
      return {'error': ps.get('enter_alphabet_characters_only')};
    } else
      return null;
  }

  static Map<String, String> alphaEn(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[a-zA-Z ]').allMatches(control.value).length !=
        control.value.length) {
      final ps = new PhraseService();
      return {'error': ps.get('enter_alphabet_characters_only')};
    } else
      return null;
  }

  static Map<String, String> alphaNumeric(AbstractControl control) {
    if ((required())(control) != null) return null;

    final value = control.value;
    final r = new RegExp(r'[a-zA-ZåäöÅÄÖ0-9 ]');
    if (r.allMatches(value).length != value.length) {
      final ps = new PhraseService();
      return {'error': ps.get('enter_alpha_numeric_values_only')};
    } else
      return null;
  }

  static Map<String, String> email(AbstractControl control) {
    if ((required())(control) != null) return null;

    final r = new RegExp(r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)');
    if (r.stringMatch(control.value) != control.value) {
      final ps = new PhraseService();
      return {
        'error': ps.get('invalid_email', params: {'email': control.value})
      };
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
        final ps = new PhraseService();
        return {'error': ps.get('enter_integers_only')};
      }
      return null;
    }
  }

  static Map<String, String> linkedInId(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[a-z0-9åäö\-\\/]{5,50}').stringMatch(control.value) !=
        control.value) {
      final ps = new PhraseService();
      return {'error': ps.get('invalid_linkedin_id')};
    } else
      return null;
  }

  static Map<String, String> lowercase(AbstractControl control) {
    if ((required())(control) != null) return null;

    final value = control.value;
    if (value == value.toLowerCase())
      return null;
    else {
      final ps = new PhraseService();
      return {'error': ps.get('lowercase_letters_only')};
    }
  }

  static ValidatorFn minLength(num minLength) => (control) {
        if (Validators.required(control) != null) return null;

        final v = control.value;
        if (v.length < minLength) {
          final ps = new PhraseService();
          return {
            'minlength': {
              'requiredLength': minLength,
              'actualLength': v.length
            },
            'error': ps.get('enter_at_least_num_letters',
                params: {'num': minLength.toString()})
          };
        }
        return null;
      };

  static Map<String, String> noSpaces(AbstractControl control) {
    if ((required())(control) != null) return null;
    final v = control.value.toString();
    if (v.contains(' ')) {
      final ps = new PhraseService();
      return {'error': ps.get('enter_no_spaces')};
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
        final ps = new PhraseService();
        return {'error': ps.get('enter_numbers_only')};
      }
      return null;
    }
  }

  static Map<String, String> phoneNumber(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[+][0-9]{2}[1-9][0-9\- ]{6,32}').stringMatch(control.value) !=
        control.value) {
      final ps = new PhraseService();
      return {'error': ps.get('enter_valid_phone')};
    } else
      return null;
  }

  static Map<String, String> phoneNumberWithoutCountryCode(AbstractControl control) {
    if ((required())(control) != null) return null;

    if (new RegExp(r'[1-9][0-9\- ]{6,32}').stringMatch(control.value) !=
        control.value) {
      final ps = new PhraseService();
      return {'error': ps.get('enter_valid_phone')};
    } else
      return null;
  }

  static Map<String, String> swedishCellphoneNumber(AbstractControl control) {
    if (required()(control) != null) return null;
    if (new RegExp('07[0-9]{8}').stringMatch(control.value) != control.value) {
      final ps = new PhraseService();
      return {'error': ps.get('enter_valid_swedish_cellphone_without_spaces')};
    } else
      return null;
  }

  static Map<String, String> swedishSocialSecurityNumber(
      AbstractControl control) {
    if ((required())(control) != null) return null;

    final r = new RegExp(
        '(19|20)[0-9]{2,2}(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-2])[0-9]{4,4}');
    if (r.stringMatch(control.value) != control.value) {
      final ps = new PhraseService();
      return {'error': ps.get('enter_valid_swedish_ssn')};
    } else
      return null;
  }

  static Map<String, String> url(AbstractControl control) {
    if ((required())(control) != null) return null;
    final r = new RegExp(
        r'https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_+.~#?&/=]*)');
    if (r.stringMatch(control.value) != control.value) {
      final ps = new PhraseService();
      return {'error': ps.get('invalid_url')};
    } else
      return null;
  }

  static Map<String, String> noWhiteSpace(AbstractControl control) {
    if ((required())(control) != null) return null;
    if (control.value.toString().contains(' ')) {
      final ps = new PhraseService();
      return {'error': ps.get('no_whitespace_allowed')};
    } else
      return null;
  }

  static Map<String, String> youtubeId(AbstractControl control) {
    if ((required())(control) != null) return null;
    if (new RegExp(r'[a-zA-Z0-9_-]{11}').stringMatch(control.value) !=
        control.value) {
      final ps = new PhraseService();
      return {'error': ps.get('invalid_youtube_id')};
    } else
      return null;
  }
}
