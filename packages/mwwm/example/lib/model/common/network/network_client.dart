import 'package:http/http.dart' show Response;

/// Custom http client interface
abstract class NetworkClient {
  /// Make http GET request
  Future<Response> get(String url);
}
