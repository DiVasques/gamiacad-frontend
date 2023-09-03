class UnauthorizedException implements Exception {
  String message;
  UnauthorizedException({
    this.message =
        'Usuário não autorizado. Por favor, realize o login novamente.',
  });

  @override
  String toString() {
    return message;
  }
}
