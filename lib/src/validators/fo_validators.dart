import 'package:angular_forms/angular_forms.dart';
import 'package:fo_components/src/services/phrase_service.dart';

class FoValidators
{
  static ValidatorFn required([String error_phrase = "enter_a_value"])
  {
    return (AbstractControl control)
    {
      if (control.value == null || control.value.toString().isEmpty)
      {
        final PhraseService ps = new PhraseService();
        return {"error" : ps.get(error_phrase)};
      }
      else return null;
    };
  }

  static Map<String, String> alpha(AbstractControl control)
  {
    if (required() != null) return null;

    if (new RegExp(r"[a-zA-ZåäöÅÄÖ]").allMatches(control.value).length != control.value.length)
    {
      final PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_alphabet_characters_only")};
    }
    else return null;
  }

  static Map<String, String> alphaNumeric(AbstractControl control)
  {
    if (required() != null) return null;

    String value = control.value;
    RegExp r = new RegExp(r"[a-zA-ZåäöÅÄÖ0-9 ]");
    if (r.allMatches(value).length != value.length)
    {
      final PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_alpha_numeric_values_only")};
    }
    else return null;
  }

  static Map<String, String> email(AbstractControl control)
  {
    if (required() != null) return null;

    RegExp r = new RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    Match m = r.firstMatch(control.value);
    if (m == null || m.groupCount != 1 || m.group(0) != control.value)
    {
      final PhraseService ps = new PhraseService();
      return {"error":ps.get("invalid_email")};
    }
    else return null;
  }

  static Map<String, String> linkedInId(AbstractControl control)
  {
    if (required() != null) return null;

    if (new RegExp(r"[a-z0-9åäö\-\\/]{5,50}").stringMatch(control.value) != control.value)
    {
      final PhraseService ps = new PhraseService();
      return {"error":ps.get("invalid_linkedin_id")};
    }
    else return null;
  }

  static Map<String, String> numeric(AbstractControl control)
  {
    if (required() != null) return null;

    if (control.value is num) return null;
    else
    {
      try { num.parse(control.value); }
      on FormatException
      {
        final PhraseService ps = new PhraseService();
        return {"error" : ps.get("enter_numbers_only")};
      }
      return null;
    }
  }

  static Map<String, String> phoneNumber(AbstractControl control)
  {
    if (required() != null) return null;

    if (new RegExp("[\+]{0,1}[0-9\- ]{7,32}").stringMatch(control.value) != control.value)
    {
      final PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_valid_phone")};
    }
    else return null;
  }

  static Map<String, String> swedishCellphoneNumber(AbstractControl control)
  {
    if (required() != null) return null;
    if (new RegExp("07[0-9]{8}").allMatches(control.value).length != control.value.length)
    {
      final PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_valid_swedish_cellphone_without_spaces")};
    }
    else return null;
  }

  static Map<String, String> swedishSocialSecurityNumber(AbstractControl control)
  {
    if (required() != null) return null;
    RegExp r = new RegExp("(19|20)[0-9]{2,2}(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-2])[0-9]{4,4}");
    if (r.allMatches(control.value).length != control.value.length)
    {
      final PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_valid_swedish_ssn")};
    }
    else return null;
  }

  static Map<String, String> url(AbstractControl control)
  {
    if (required() != null) return null;
    RegExp r = new RegExp(r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");
    if (r.stringMatch(control.value) != control.value)
    {
      final PhraseService ps = new PhraseService();
      return {"error":ps.get("invalid_url")};
    }
    else return null;
  }

  static Map<String, String> youtubeId(AbstractControl control)
  {
    if (required() != null) return null;
    String match = new RegExp(r"[a-zA-Z0-9_]{11}").stringMatch(control.value);
    if (match == null || match != control.value)
    {
      final PhraseService ps = new PhraseService();
      return {"error":ps.get("invalid_youtube_id")};
    }
    else return null;
  }
}