/// incompatible data blocks
class IncompatibleRangesException implements Exception {
  final message;

  IncompatibleRangesException([this.message]);

  String toString() {
    if (message == null) return "IncompatibleRangesException";
    return "IncompatibleRangesException: $message";
  }
}
