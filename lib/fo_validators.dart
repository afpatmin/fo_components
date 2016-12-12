import 'package:angular2/common.dart' show AbstractControl, Validators;

class FoValidators
{
  static Map<String, Map<String, String>> isAlpha(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, Map<String, String>> output;
    if (value.length < 5)
    {
      output["isPhone"] = new Map();
      output["isPhone"]["value"] = value;
    }
    return output;
  }

  static Map<String, Map<String, String>> isAlphaNumeric(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, Map<String, String>> output;
    if (value.length < 5)
    {
      output["isPhone"] = new Map();
      output["isPhone"]["value"] = value;
    }
    return output;
  }

  static Map<String, Map<String, String>> isEmail(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, Map<String, String>> output;

    if (value.length < 5)
    {
      output = new Map();
      output["isEmail"] = new Map();
      output["isEmail"]["value"] = value;
    }
    return output;
  }

  static Map<String, Map<String, String>> isPhone(AbstractControl control)
  {
    if (Validators.required(control) != null) return null;
    String value = control.value;
    Map<String, Map<String, String>> output;
    if (value.length < 5)
    {
      output["isPhone"] = new Map();
      output["isPhone"]["value"] = value;
    }
    return output;
  }
}