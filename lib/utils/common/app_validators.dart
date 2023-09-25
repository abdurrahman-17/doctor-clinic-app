/*

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Invalid Email';
  } else {
    return null;
  }
}

String validateUrl(String url) {
  Pattern urlPattern = r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  var result = new RegExp(urlPattern, caseSensitive: false).firstMatch(url);

  if (result != null) {
    return ' Invalid URL';
  } else {
    return ' Valid URL';
  }
}
*/

String? validateEmptyCheck(String value, String errorText) {
  return value.trim().length < 1 ? errorText : null;
}

// Empty Check feature and minimum required length condition Validation(like CVV, Minimum Name Field of Character Length, Message field of Minimum content length etc...)
int validateEmptyAndLengthCheck(String stringValue, int maxLength,
    {int minLength = 0}) {
  // 0 = null
  // 1 = Empty Field
  // 4 = requiredLength

  int errorFlag = 0;

  if (stringValue.length > 0) {
    if (minLength != 0 && stringValue.length < minLength) {
      errorFlag = 4;
    } else {
      errorFlag = 0;
    }
  } else {
    errorFlag = 1;
  }

  return errorFlag;
}

// Error Message's Container.
String validatedFieldOfErrorMessage(int errorFlag,
    {required String fieldName, required int requiredLength}) {
  // errorFlag :  It is thrown from different validator methods, So each flag represent unique error message.
  // fieldName :  Here fieldName can be consider as Field Label Name or value of Field, that to show in error message.
  // requiredLength :  Field value/String value of required min length to show in Error message.

  var msg;
  switch (errorFlag) {
    case 0:
      {
        msg = null;
      }
      break;
    case 1:
      {
        msg = "$fieldName can't be empty";
      }
      break;
    case 2:
      {
        msg = "Min 5 char required";
      }
      break;
    case 3:
      {
        msg = "Password doesn't match";
      }
      break;
    case 4:
      {
        msg = "Minimum $requiredLength Character are required.";
      }
      break;
    default:
      {
        msg = null;
      }
      break;
  }
  return msg;
}

String? validateText(String? formText) {
  if (formText!.isEmpty) return "Field is Required";

  return null;
}

String? validateEmail(String? formEmail) {
  if (formEmail!.isEmpty) return "Email Is Required";

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid Email';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword!.isEmpty) return "Password Is Required";

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  String letterPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])';
  String numberPattern = r'^(?=.*?[0-9])';
  String characterPattern = r'^(?=.*?[!@#\$&*~])';
  RegExp regex = RegExp(pattern);
  RegExp regexLetter = RegExp(letterPattern);
  RegExp regexNumber = RegExp(numberPattern);
  RegExp regexCharacter = RegExp(characterPattern);
  // if (!regex.hasMatch(formPassword)) {
  //   return '''
  //   Password must be at least 8 character
  //   include an uppercase letter, number and symbol.
  //   ''';
  // }

  if (formPassword.length < 8) {
    return 'Password must be at least 8 character';
  } else if (!regexLetter.hasMatch(formPassword)) {
    return 'Should contain Atleast one Capital Letter';
  } else if (!regexNumber.hasMatch(formPassword)) {
    return 'Should contain Atleast one Number';
  } else if (!regexCharacter.hasMatch(formPassword)) {
    return 'Should contain Atleast one Symbol';
  }
}

String? validateSimplePassword(String? formPassword) {
  if (formPassword!.isEmpty) return "Password Is Required";
}

String? validateNumber(String? formText) {
  if (formText!.isEmpty) {
    return "Number is Required";
  } else if (formText.length < 10) {
    return "Entered Number is less than 10";
  }
  return null;
}

String? validateAddress(String? formText) {
  if (formText!.isEmpty) {
    return "Address is Required";
  } else if (formText.length < 6) {
    return "Please Enter At Least 6 character";
  }
  return null;
}

// String? validateConfirmPassword(String? formConfirmPassword) {
//   if (formConfirmPassword!.isEmpty) {
//     return "Password Is Required";
//   }
//   if (_password.text != formConfirmPassword) {
//     return "Password Does Not Match";
//   }
//   return null;
// }
