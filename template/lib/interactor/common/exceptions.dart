class MessagedException implements Exception {
  final String message;

  MessagedException(this.message);
}

class OtpException implements Exception {}

class UserNotFoundException implements Exception {}

class NotFoundException extends MessagedException {
  NotFoundException(String message) : super(message);
}
