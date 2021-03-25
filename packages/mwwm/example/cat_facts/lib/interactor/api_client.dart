import 'package:http/http.dart' as http;

class ApiClient {
  static final _baseUrl = 'https://cat-fact.herokuapp.com';
  static final http.Client httpClient = http.Client();

  static Future<http.Response> get(String endpoint) =>
      httpClient.get(Uri.parse(_baseUrl + endpoint));
}
