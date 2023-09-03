class ForbiddenException implements Exception {
  String message;
  ForbiddenException({
    this.message = 'Acesso negado.',
  });

  @override
  String toString() {
    return message;
  }
}
