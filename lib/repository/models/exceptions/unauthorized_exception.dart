class UnauthorizedException implements Exception {
  UnauthorizedException({
    String message =
        'Usuário não autorizado. Por favor, realize o login novamente.',
  });
}
