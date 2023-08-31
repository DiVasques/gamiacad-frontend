class UserExistsException implements Exception {
  UserExistsException({
    String message = 'Usuário já cadastrado com o CPF informado.',
  });
}
