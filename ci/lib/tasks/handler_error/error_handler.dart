abstract class ErrorHandler {
  Future<void> handler(Exception e, StackTrace stackTrace);
}
