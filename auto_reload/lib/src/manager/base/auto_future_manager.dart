/// return id of success future in queue
typedef AutoFutureCallback = Function(String id);

/// Manager for endless replay [Future], until will not be performed
abstract class AutoFutureManager {
  /// register [Future] to auto reload
  ///
  /// [id] - number of future in queue
  /// [toReload] - himself future on reboot
  /// [onComplete] - callback of success future, that returns id in queue
  Future<void> autoReload({
    String id,
    Future toReload(),
    AutoFutureCallback onComplete,
  });
}
