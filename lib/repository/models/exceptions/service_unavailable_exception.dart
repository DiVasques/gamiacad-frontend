class ServiceUnavailableException implements Exception {
  ServiceUnavailableException({
    String message = 'Serviço indisponível. Tente novamente mais tarde.',
  });
}
