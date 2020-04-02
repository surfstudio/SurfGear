/// IOS plugin initialization settings
class IOSInitSettings {
  /// Request permission to display a notification.
  /// The default value is true
  final bool requestAlertPermission;

  /// Request permission to play notification sound
  /// The default value is true
  final bool requestSoundPermission;

  const IOSInitSettings({
    this.requestAlertPermission = true,
    this.requestSoundPermission = true,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestAlertPermission': requestAlertPermission,
      'requestSoundPermission': requestSoundPermission,
    };
  }
}
