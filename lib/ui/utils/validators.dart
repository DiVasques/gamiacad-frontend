import 'package:gami_acad/ui/utils/error_messages.dart';

class FieldValidators {
  static String? validateEmail(String? input) {
    input!.trim();
    String regexString = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp validEmailPattern = RegExp(regexString);
    if (validEmailPattern.hasMatch(input)) {
      return null;
    } else {
      return ErrorMessages.invalidEmail;
    }
  }

  static String? validatePwd(String? input) {
    int pwdLength = input!.length;
    RegExp validPasswordPattern =
        RegExp(r'^(?=.*\d)(?=.*[A-Za-z])(?=.*\W).{12,}$');
    if (pwdLength < 12) {
      return ErrorMessages.invalidPasswordLength;
    }
    if (!validPasswordPattern.hasMatch(input)) {
      return ErrorMessages.invalidPassword;
    }
    return null;
  }

  static String? validateRegistration(String? input) {
    input!.trim();
    RegExp validRegistrationPattern = RegExp(r'^[0-9]{11}$');
    if (validRegistrationPattern.hasMatch(input)) {
      return null;
    } else {
      return ErrorMessages.invalidRegistration;
    }
  }

  static String? validateName(String? input) {
    input!.trim();
    RegExp validRegistrationPattern =
        RegExp(r'''^[ \p{L}\p{N}`'-]{5,50}$''', unicode: true);
    if (validRegistrationPattern.hasMatch(input)) {
      return null;
    } else {
      return ErrorMessages.invalidName;
    }
  }
}
