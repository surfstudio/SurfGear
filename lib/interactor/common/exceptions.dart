class MessagedException implements Exception {
  final String message;

  MessagedException(this.message);
}

/// Ошибка с требованием подтвердить по смс
class OtpException implements Exception {}

/// Ошибка с отсутсвия юзера
class UserNotFoundException implements Exception {}

/// Ошибка: ответ не найден
class NotFoundException extends MessagedException {
  NotFoundException(String message) : super(message);
}
