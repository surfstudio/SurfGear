import 'dart:async';
import 'auto_reloader.dart';

/// Mixin that implements the auto-reload
///
/// usage:
/// * apply this mixin on a class
/// * override [autoReload]
/// * call [startAutoReload] and [cancelAutoReload]
mixin AutoReloadMixin on AutoReloader {
  final Duration autoReloadDuration = const Duration(minutes: 5);

  Timer _autoReloadTimer;

  void startAutoReload() {
    cancelAutoReload();
    _autoReloadTimer = Timer.periodic(
      autoReloadDuration,
      (_) => autoReload(),
    );
  }

  void cancelAutoReload() {
    _autoReloadTimer?.cancel();
    _autoReloadTimer = null;
  }
}
