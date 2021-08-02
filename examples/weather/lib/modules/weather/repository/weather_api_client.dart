import 'package:http/http.dart';

/// Класс для взаимодействия с API слоем.
class WeatherApiClient {
  final Client httpClient;

  final String _baseUrl;

  WeatherApiClient(this._baseUrl, this.httpClient);

  /// получает клиент и параметры, по которым и делает запрос. Возвращает Future<Response>
  Future<Response> get(String endpoint, {Map<String, String>? params}) {
    final queryString = Uri(queryParameters: params).query;
    return httpClient.get(Uri.parse('$_baseUrl$endpoint?$queryString'));
  }
}
