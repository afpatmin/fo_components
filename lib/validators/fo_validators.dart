import 'package:angular_forms/angular_forms.dart';
import 'package:intl/intl.dart';

// ignore: avoid_classes_with_only_static_members
class FoValidators {
  static Map<String, String>? alpha(AbstractControl control) {
    if (Validators.required(control) != null) return null;

    if (RegExp(r'[a-zA-ZåäöÅÄÖ ]').allMatches(control.value as String).length !=
        control.value.length) {
      return {
        'error': Intl.message('Enter alphabet characters only',
            name: 'fo_validator_error_alpha')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? alphaEn(AbstractControl control) {
    if (Validators.required(control) != null) return null;

    if (RegExp(r'[a-zA-Z ]').allMatches(control.value as String).length !=
        control.value.length) {
      return {
        'error': Intl.message('Enter alphabet characters only',
            name: 'fo_validator_error_alpha_en')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? alphaNumeric(AbstractControl control) {
    if (Validators.required(control) != null) return null;

    final value = control.value as String;
    final r = RegExp(r'[a-zA-ZåäöÅÄÖ0-9 ]');
    if (r.allMatches(value).length != value.length) {
      return {
        'error': Intl.message('Enter alpha-numeric characters only',
            name: 'fo_validator_error_alpha_numeric')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? alphaNumericEn(AbstractControl control) {
    if (Validators.required(control) != null) return null;

    final value = control.value as String;
    final r = RegExp(r'[a-zA-Z0-9 ]');
    if (r.allMatches(value).length != value.length) {
      return {
        'error': Intl.message('Enter alpha-numeric characters only',
            name: 'fo_validator_error_alpha_numeric_en')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? email(AbstractControl control) {
    if (Validators.required(control) != null) return null;

    final r = RegExp(r'(^[a-z0-9_.+-]+@[a-z0-9-]+\.[a-z0-9-.]+$)');
    if (r.stringMatch(control.value as String) != control.value) {
      return {
        'error': Intl.message('Invalid email', name: 'fo_validator_error_email')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? integer(AbstractControl control) {
    if (Validators.required(control) != null) {
      return null;
    } else if (control.value == null) {
      return null;
    } else if (control.value is int) {
      return null;
    } else {
      try {
        int.parse(control.value as String);
      } on FormatException {
        return {
          'error': Intl.message('Enter integer values only',
              name: 'fo_validator_error_integer')
        };
      }
      return null;
    }
  }

  static Map<String, String>? linkedInId(AbstractControl control) {
    if (Validators.required(control) != null) return null;

    if (RegExp(r'[a-z0-9åäö\-\\/]{5,50}')
            .stringMatch(control.value as String) !=
        control.value) {
      return {
        'error': Intl.message('Invalid LinkedIn id',
            name: 'fo_validator_error_linkedin_id')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? metaDescription(AbstractControl control) {
    if (Validators.required(control) != null) return null;

    final value = control.value as String;
    final r = RegExp(r'[a-zA-ZåäöÅÄÖ0-9,.! ]');
    if (value is String && r.allMatches(value).length != value.length) {
      return {
        'error': Intl.message('Enter a value without special characters',
            name: 'fo_validator_error_meta_description')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? noWhiteSpace(AbstractControl control) {
    if (Validators.required(control) != null) return null;
    if (control.value.toString().contains(' ')) {
      return {
        'error': Intl.message('Enter a value without spaces',
            name: 'fo_validator_error_no_white_space')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? numeric(AbstractControl control) {
    if (Validators.required(control) != null) return null;

    if (control.value is num) {
      return null;
    } else {
      try {
        num.parse(control.value as String);
      } on FormatException {
        return {
          'error': Intl.message('Enter a numeric value',
              name: 'fo_validator_error_numeric')
        };
      }
      return null;
    }
  }

  static Map<String, String>? phoneNumber(AbstractControl control) {
    if (Validators.required(control) != null) return null;

    if (RegExp(r'([+][1-9]{1,3})?[0-9\- ]{6,32}')
            .stringMatch(control.value as String) !=
        control.value) {
      return {
        'error': Intl.message('Enter a valid phone number',
            name: 'fo_validator_error_phone_number')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? url(AbstractControl control) {
    if (Validators.required(control) != null) return null;
    final r = RegExp(
        r'https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_+.~#?&/=]*)');
    if (r.stringMatch(control.value as String) != control.value) {
      return {
        'error': Intl.message('Invalid URL', name: 'fo_validator_error_url')
      };
    } else {
      return null;
    }
  }

  static Map<String, String>? youtubeId(AbstractControl control) {
    if (Validators.required(control) != null) return null;
    if (RegExp(r'[a-zA-Z0-9_-]{11}').stringMatch(control.value as String) !=
        control.value) {
      return {
        'error': Intl.message('Invalid Youtube id',
            name: 'fo_validator_error_youtube_id')
      };
    } else {
      return null;
    }
  }
}
