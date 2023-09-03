class BadRequestException implements Exception {
  String message;
  BadRequestException({
    this.message = 'Ocorreu um erro. Tente novamente mais tarde.',
  });

  @override
  String toString() {
    return message;
  }
}
