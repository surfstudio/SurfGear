class MessagedException implements Exception {
  final String message;

  MessagedException(this.message);
}

/// Ошибка: ответ не найден
class NotFoundException extends MessagedException {
  NotFoundException(String message) : super(message);
}
