class MessagedException implements Exception {
  MessagedException(this.message);

  final String message;
}

/// Ошибка: ответ не найден
class NotFoundException extends MessagedException {
  NotFoundException(String message) : super(message);
}
