/// Manager for endless replay [Future], until will not be performed
abstract class AutoFutureManager {
  /// register [Future] to auto reload
  Future<void> autoReload({
    String id,
    Future toReload(),
    Function onComplete,
  });
}
