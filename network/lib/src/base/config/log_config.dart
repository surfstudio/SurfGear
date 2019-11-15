class LogConfig {
  /// Print request options
  final bool options;

  /// Print request header
  final bool requestHeader;

  /// Print request data
  final bool requestBody;

  /// Print
  final bool responseBody;

  /// Print
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// Log size per print
  final int logSize;

  LogConfig({
    this.options = false,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseBody = true,
    this.responseHeader = true,
    this.error = true,
    this.logSize = 2048,
  });
}
