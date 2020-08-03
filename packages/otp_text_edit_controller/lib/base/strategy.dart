/// Strategy interface, another variant of code input
abstract class OTPStrategy {
  Future<String> listenForCode();
}