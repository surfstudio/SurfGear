///Http configuration
class HttpConfig {
  final String baseUrl;
  final Duration timeout;
  final String proxyUrl;

  HttpConfig(this.baseUrl, this.timeout, {this.proxyUrl});
}
