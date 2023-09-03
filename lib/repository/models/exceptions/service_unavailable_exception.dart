class ServiceUnavailableException implements Exception {
  String message;
  ServiceUnavailableException({
    this.message = 'Serviço indisponível. Tente novamente mais tarde.',
  });

  @override
  String toString() {
    return message;
  }
}
