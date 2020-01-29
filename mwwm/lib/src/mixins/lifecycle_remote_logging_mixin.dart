import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// Mixin for logging widget [State] lifecycle.
///
/// Unlike [LifecycleLoggingMixin] this implementations has an ability to log
/// widget state not only to console, but also to the remote logger (i.e.
/// Crashlytics) with the help of [Logger] class.
///
/// Please note that logging to a remote logger will only work in case of
/// correct configuration of [RemoteLogger] strategy in your project.
///
/// It's should not be used with [LifecycleLoggingMixin] at the same time due to
/// logs duplication issue.
mixin LifecycleRemoteLoggingMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    Logger.i("${this} initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Logger.i("${this} didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    Logger.i("${this} dispose");
  }
}
