typedef ExtractStringCallback = String Function(String);

/// Strategy interface, another variant of code input
/// e.g. from push notification or for testing
abstract class OTPStrategy {
  Future<String> listenForCode();
}
