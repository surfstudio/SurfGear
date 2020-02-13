/// Error Handler
abstract class ErrorHandler {
  Future<void> handle(Exception e, StackTrace stackTrace);
}
