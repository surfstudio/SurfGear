#### [SurfGear](https://github.com/surfstudio/SurfGear)

# auto_reload

A library that helps to perform actions with some periodicity

## Usage of AutoReload

main classes:

1. [AutoReloader](/lib/src/mixin/auto_reloader.dart)
1. [AutoReloadMixin](/lib/src/mixin/auto_reload_mixin.dart)

usage:

1. Create abstract class that should be able to reload data should implements [AutoReloader]
2. Apply mixin on a child (that implements [AutoReloader])
3. override [autoReload]
4. call [startAutoReload] for start and [cancelAutoReload] for dispose

## Usage of AutoRequestManager

main classes:

1. [AutoFutureManager](/lib/src/manager/base/auto_future_manager.dart)
2. [AutoRequestManager](/lib/src/manager/impl/auto_request_manager.dart)

Main feature of [AutoRequestManager] that requests will only start restarting when a connection is made.
It implemented by a third-party library names connectivity. (https://pub.dev/packages/connectivity)

usage:

1. Add your request in #autoReload
2. Wait callback about successful completion
