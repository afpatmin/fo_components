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

  static Map<String, String> isSwedishCellphoneNumber(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, String> output = new Map();

    RegExp r = new RegExp("07[0-9]{8}");
    if (r.allMatches(value).length != 1)
    {
      output["material-input-error"] = "Enter a valid swedish cell phone number without spaces (07xxxxxxxx)";
    }
    return output;
  }
}