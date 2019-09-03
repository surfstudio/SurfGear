# logger

Logger for Dart & Flutter

## Использование

Основные классы:
1. [Logger](lib/src/logger.dart)
2. [RemoteLogger](lib/src/remote_logger.dart)

## Logger

Logger используется как синглтон. Основные методы:
* .d - debug
* .w - warn, для ожидаемой ошибки
* .e - error

Стратегии логирования можно дополнять, реализуя наследника `LogStrategy`

При добавлении `RemoteLogStrategy` на удаленный сервер отправляются все логи выше уровня WARN

Чтобы не загрязнять Crashlytics используем `Logger#w()` для ожидаемых ошибок