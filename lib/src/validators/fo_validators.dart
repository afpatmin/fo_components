import 'package:angular2/angular2.dart';
import 'package:fo_components/src/services/phrase_service.dart';

class FoValidators
{
  static Map<String, String> required(AbstractControl control)
  {
    if (control.value == null || control.value.isEmpty)
    {
      PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_a_value")};
    }
    else return null;
  }

  static Map<String, String> alpha(AbstractControl control)
  {
    if (required(control) != null) return null;

    String value = control.value;
    RegExp r = new RegExp(r"[a-zA-ZåäöÅÄÖ]");
    if (r.allMatches(value).length != value.length)
    {
      PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_alphabet_characters_only")};
    }
    else return null;
  }

  static Map<String, String> alphaNumeric(AbstractControl control)
  {
    if (required(control) != null) return null;

    String value = control.value;
    RegExp r = new RegExp(r"[a-zA-ZåäöÅÄÖ0-9 ]");
    if (r.allMatches(value).length != value.length)
    {
      PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_alpha_numeric_values_only")};
    }
    else return null;
  }

  static Map<String, String> numeric(AbstractControl control)
  {
    if (control.value is num) return null;
    else
    {
      try { num.parse(control.value); }
      on FormatException
      {
        PhraseService ps = new PhraseService();
        return {"error" : ps.get("enter_numbers_only")};
      }
      return null;
    }
  }

  static Map<String, String> phoneNumber(AbstractControl control)
  {
    if (required(control) != null) return null;

    RegExp r = new RegExp("[\+]{0,1}[0-9\- ]{7,32}");
    if (r.stringMatch(control.value) != control.value)
    {
      PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_valid_phone")};
    }
    else return null;
  }

  static Map<String, String> swedishCellphoneNumber(AbstractControl control)
  {
    if (required(control) != null) return null;

    RegExp r = new RegExp("07[0-9]{8}");
    if (r.allMatches(control.value).length != control.value.length)
    {
      PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_valid_swedish_cellphone_without_spaces")};
    }
    else return null;
  }

  static Map<String, String> swedishSocialSecurityNumber(AbstractControl control)
  {
    if (required(control) != null) return null;

    RegExp r = new RegExp("(19|20)[0-9]{2,2}(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-2])[0-9]{4,4}");

    if (r.allMatches(control.value).length != control.value.length)
    {
      PhraseService ps = new PhraseService();
      return {"error" : ps.get("enter_valid_swedish_ssn")};
    }
    else return null;
  }
}