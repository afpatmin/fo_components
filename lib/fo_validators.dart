library fo_validators;

import 'package:angular2/common.dart' show AbstractControl, Validators;

class FoValidators
{
  static Map<String, String> isAlpha(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, String> output = new Map();

    RegExp r = new RegExp(r"[a-zA-ZåäöÅÄÖ]");
    if (r.allMatches(value).length != value.length)
    {
      output["material-input-error"] = "Enter alphabet characters only";
    }
    return output;
  }

  static Map<String, String> isName(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, String> output = new Map();

    RegExp r = new RegExp(r"[a-zA-ZåäöÅÄÖ\- ]");
    if (r.allMatches(value).length != value.length)
    {
      output["material-input-error"] = "Enter alphabet characters only";
    }
    return output;
  }

  static Map<String, String> isAlphaNumeric(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, String> output = new Map();

    RegExp r = new RegExp(r"[a-zA-ZåäöÅÄÖ0-9]");
    if (r.allMatches(value).length != value.length)
    {
      output["material-input-error"] = "Enter alpha-numeric characters only";
    }
    return output;
  }

  static Map<String, String> isNumeric(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, String> output = new Map();
    RegExp r = new RegExp("[0-9]+");
    if (r.stringMatch(value) == null || r.stringMatch(value).length != value.length)
    {
      output["material-input-error"] = "Enter numbers only";
    }
    return output;
  }

  static Map<String, String> isPhoneNumber(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, String> output = new Map();
    RegExp r = new RegExp("[\+]{0,1}[0-9]{7,32}");
    if (r.stringMatch(value) == null || r.stringMatch(value).length != value.length)
    {
      output["material-input-error"] = "Enter a valid phone number without spaces or dashes (+461234567)";
    }
    return output;
  }

  static Map<String, String> isSwedishCellphoneNumber(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, String> output = new Map();

    RegExp r = new RegExp("07[0-9]{8}");
    if (r.stringMatch(value) == null || r.stringMatch(value).length != value.length)
    {
      output["material-input-error"] = "Enter a valid swedish cell phone number without spaces (0712345678)";
    }
    return output;
  }

  static Map<String, String> isSwedishSocialSecurityNumber(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, String> output = new Map();
    RegExp r = new RegExp("(19|20)[0-9]{2,2}(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-2])[0-9]{4,4}");
    if (r.stringMatch(value) == null || r.stringMatch(value).length != value.length)
    {
      output["material-input-error"] = "Enter a valid swedish social security number without spaces or symbols (YYYYMMDDXXXX)";
    }
    return output;
  }

  static Map<String, String> isCancelBookingCode(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, String> output = new Map();
    RegExp r = new RegExp("[A-Z]{3}[0-9]{3}");
    if (r.stringMatch(value) == null || r.stringMatch(value).length != value.length)
    {
      output["material-input-error"] = "Enter a value matching the following format: ABC123";
    }
    return output;
  }
}