



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
  static String? validateEmail(String value, {FocusNode? focusNode}) {
    if (value.isEmpty) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "invalid";
    } else if (!GetUtils.isEmail(value.trim())) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "invalid";
    }
    return null;
  }

  static String? validateEmptyEmail(String value) {
    if (!GetUtils.isEmail(value.trim()) && value.isNotEmpty) {
      return "invalid";

    }
    return null;
  }
}

/*================================================== Password Validator ===================================================*/

class PasswordFormValidator {
  static String? validatePassword(String value) {
    var pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "invalid";
    } else if (value.length < 8) {
      return "invalid";
    } else if (!regExp.hasMatch(value)) {
      return "invalid";
    }
    return null;
  }

  static String? validateConfirmPasswordMatch(String? value, String? password) {
    if (value!.isEmpty) {
      return "invalid";
    } else if (value.length < 8) {
      return "invalid";
    } else if (value != password) {
      return "invalid";
    }
    return null;
  }
}

/*================================================== Phone Number Validator ===================================================*/

class PhoneNumberValidate {
  static String? validateMobile(String value, {FocusNode? focusNode}) {
    if (value.isEmpty) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "invalid";
    } else if (value.length < 8 || value.length > 15) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return 'invalid';
    } else if (!validateNumber(value)) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "invalid";
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
  static String? fieldChecker(String? value, message, {FocusNode? focusNode}) {
    if (value == null || value.toString().trim().isEmpty) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "$message cannot be empty";
    }
    return null;
  }
}

class PriceFieldChecker {
  static String? fieldChecker(String? value, message, {FocusNode? focusNode}) {
    if (value == null || value.toString().trim().isEmpty) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return '$message cannot be empty';
    } else if (value.toString().trim().startsWith('0')) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return '$message cannot start with 0';
    }
    return null;
  }
}
