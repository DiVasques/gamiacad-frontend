class ErrorMessages {
  static const invalidInputs = 'INVALID_INPUTS';
  static const unknownError = 'Erro desconhecido.';
  static const alreadyRegistered = 'CPF já registrado.';
  static const failedLoginAttempt = 'CPF e/ou senha incorretos.';

  static String getExceptionMessage(Exception exception) {
    return exception.toString().replaceAll('Exception: ', '');
  }
}