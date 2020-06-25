/// There isn't internet connection
class NoInternetException implements Exception {
  NoInternetException({this.message});

  final String message;

  @override
  String toString() => message ?? 'There is not internet connection';
}
