/// incompatible data blocks
class IncompatibleRangesException implements Exception {
  IncompatibleRangesException([this.message]);

  final String message;

  @override
  String toString() {
    if (message == null) return 'IncompatibleRangesException';
    return 'IncompatibleRangesException: $message';
  }
}
