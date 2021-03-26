import 'package:http/http.dart' as http;

class ApiClient {
  final _baseUrl = 'https://cat-fact.herokuapp.com';
  final http.Client httpClient = http.Client();

  Future<http.Response> get(String endpoint) =>
      httpClient.get(Uri.parse(_baseUrl + endpoint));
}
