/// Android notification settings
class AndroidNotificationSpecifics {
  ///Icon drawable
  ///
  /// @mipmap/ic_launcher
  final String icon;

  /// channelId
  ///
  /// @string/notification_channel_id
  final String channelId;

  /// channelId
  ///
  /// @string/notification_channel_name
  final String channelName;

  /// channelId
  ///
  /// @color/notification_color
  final String color;
  final bool autoCancelable;

  AndroidNotificationSpecifics({
    this.icon,
    this.channelId,
    this.channelName,
    this.color,
    this.autoCancelable,
  });

  Map<String, dynamic> toMap() {
    return {
      "icon": icon,
      "channelId": channelId,
      "channelName": channelName,
      "color": color,
      "autoCancelable": autoCancelable,
    };
  }
}
