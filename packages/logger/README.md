# logger

Logger for Dart & Flutter

## Usage

Main classes:
1. [Logger](lib/src/logger.dart)
2. [RemoteLogger](lib/src/remote_logger.dart)

## Logger

Logger is used as a singleton. The main methods:
* .d - debug
* .w - warn, for expected error
* .e - error

Logging strategies can be supplemented by implementing the `LogStrategy` heir

When adding `RemoteLogStrategy` to the remote server, all logs are sent above the WARN level

In order not to pollute Crashlytics we use `Logger # w ()` for the expected errors