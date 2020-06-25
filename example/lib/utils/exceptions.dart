/// There isn't internet connection
class NoInternetException implements Exception {
  NoInternetException({this.message});

  final String message;

  @override
  String toString() => message ?? 'There is not internet connection';
}

/// Authorization process was canceled
class CanceledAuthorizationException implements Exception {
  @override
  String toString() => 'Authorization process was canceled';
}

/// Authorization failed due to invalid data
class IncorrectClientCredentionalsException implements Exception{
  @override
  String toString() => 'Incorrect client credentionals';
}
