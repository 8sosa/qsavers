/*
 *
 *  * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 *  * @author     : Gaurav Negi
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of Henceforth Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *  *
 *
 */

/*========================Email Validator==============================================*/

import '../../export.dart';

class EmailValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return strEmailEmpty;
    } else if (!GetUtils.isEmail(value.trim())) {
      return strInvalidEmail;
    }
    return null;
  }
}

/*================================================== Password Validator ===================================================*/

class PasswordFormValidator {
  static String? validatePassword(String value, bool isOldPass) {
    if (isOldPass) {
      if (value.isEmpty) {
        return strPasswordEmpty;
      } else {
        return null;
      }
    }

    var pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return strPasswordEmpty;
    } else if (value.length < 8) {
      return strInvalidPassword;
    } else if (!regExp.hasMatch(value)) {
      return strPasswordNotSecure;
    }
    return null;
  }

  static String? deletePassword(String value, bool isOldPass) {
    if (isOldPass) {
      if (value.isEmpty) {
        return strPasswordEmpty;
      } else {
        return null;
      }
    }

    // var pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return strPasswordEmpty;
    } /*else if (value.length < 8) {
      return strInvalidPassword;
    } *//*else if (!regExp.hasMatch(value)) {
      return strPasswordNotSecure;
    }*/
    return null;
  }

  static String? validateConfirmPasswordMatch(
      {String? value, String? password}) {
    var pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return strConfirmPasswordEmpty;
    } else if (value.length < 8) {
      return strConfirmInvalidPassword;
    } else if (!regExp.hasMatch(value)) {
      return strPasswordNotSecure;
    } else if (value != password) {
      return strPasswordMatch;
    }
    return null;
  }
}

/*================================================== Phone Number Validator ===================================================*/

class PhoneNumberValidate {
  static String? validateMobile(String value) {
    if (value.isEmpty) {
      return strPhoneEmEmpty;
    } else if (value.length < 8 || value.length > 15) {
      return strPhoneNumberInvalid;
    } else if (!validateNumber(value)) {
      return strSpecialCharacter;
    }
    return null;
  }
}

bool validateNumber(String value) {
  var pattern = r'^[0-9]+$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

/*===============================Field Checker=================================================*/
class FieldChecker {
  static String? fieldChecker({String? value, message}) {
    if (value == null || value.toString().trim().isEmpty) {
      return "$message";
    }
    return null;
  }
}

/*===============================Card Month ========================================*/
class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newText.isEmpty) {
      return newValue;
    }

    // Remove any non-numeric characters
    newText = newText.replaceAll(RegExp(r'\D'), '');

    if (newText.length == 1 && int.tryParse(newText) != null && int.tryParse(newText)! > 1) {
      newText = '0$newText';
    }
    if (newText.length == 2 && newText[0] == '1') {
      if (int.tryParse(newText[1]) != null && int.tryParse(newText[1])! > 2) {
        newText = '${newText[0]}2';
      }
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      if (i == 2 && newText.length > 2) {
        buffer.write('/');
      }
      if (i >= 2) {
        buffer.write(newText[i]);
      } else {
        buffer.write(newText[i]);
      }
    }

    var string = buffer.toString();
    return TextEditingValue(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

/*=========================card year=============================*/
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

/*=========================CVC formator =========================*/
class CvcInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    // Remove any non-numeric characters
    newText = newText.replaceAll(RegExp(r'\D'), '');

    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      if (i == 2 && newText.length > 2) {
        buffer.write(
            ' '); // Add space after the third digit for better readability
      }
    }

    var string = buffer.toString();
    return TextEditingValue(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
