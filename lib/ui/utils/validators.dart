class FieldValidators {
  static String? validateEmail(String? input) {
    input!.trim();
    String regexString = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
    RegExp validEmailPattern = RegExp(regexString);
    if (validEmailPattern.hasMatch(input)) {
      return null;
    } else {
      return 'E-mail Inválido';
    }
  }

  static String? validatePwd(String? input) {
    int pwdLength = input!.length;
    if (pwdLength < 6 || pwdLength > 12) {
      return 'Senha deve ter entre 6 e 12 caracteres';
    } else {
      return null;
    }
  }

  static String? validateRegistration(String? input) {
    input!.trim();
    RegExp validRegistrationPattern = RegExp(r"^[0-9]{11}$");
    if (validRegistrationPattern.hasMatch(input)) {
      return null;
    } else {
      return 'CPF inválido';
    }
  }

  static String? validatePwdMatch(String? confirmPwd, String? pwd) {
    if (confirmPwd != pwd) return 'Senhas devem ser iguais';
    return null;
  }

  static String? validateName(String? input) {
    input!.trim();
    RegExp validRegistrationPattern = RegExp(r"^[a-zA-Z0-9 À-ÿ]{50}$");
    if (validRegistrationPattern.hasMatch(input) && input.length <= 20) {
      return null;
    } else {
      return 'Nome inválido';
    }
  }

  static String? validateNotEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }
}
