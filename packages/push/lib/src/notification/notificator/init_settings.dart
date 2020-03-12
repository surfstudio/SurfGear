import 'package:push/src/notification/notificator/ios/ios_init_settings.dart';

/// Basic notification initialization settings
/// todo подумать какие базовые настройки сделать для android
class InitSettings {
  /// Initialization Settings for ios
  final IOSInitSettings iosInitSettings;

  InitSettings({
    this.iosInitSettings,
  });
}
