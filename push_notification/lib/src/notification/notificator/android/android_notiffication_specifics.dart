/// Android notification settings
class AndroidNotificationSpecifics {
  final String icon;
  final String channelId;
  final String channelName;
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
