import 'auto_reload_mixin.dart';

/// Class providing an opportunity to participate
/// in autoload managed by [AutoReloadMixin]
abstract class AutoReloader {
  ///reloaded place here
  void autoReload() {}
}
