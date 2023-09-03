class UserExistsException implements Exception {
  String message;
  UserExistsException({
    this.message = 'Usuário já cadastrado com o CPF informado.',
  });

  @override
  String toString() {
    return message;
  }
}
