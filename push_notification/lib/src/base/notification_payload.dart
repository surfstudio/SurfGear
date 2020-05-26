/// notification base payload data
abstract class NotificationPayload {
  /// original message
  final Map<String, dynamic> messageData;

  /// field required to show notification
  final String body;
  final String title;
  final String clickUrl;
  final String imageUrl;
  final String uniqueKey;
  final Map<String, dynamic> payload;
  final List<NotificationButton> buttons;

  /// IOS Only
  final String sound;
  final int mutableContent;
  final int available;

  NotificationPayload(
    this.messageData,
    this.body,
    this.title,
    this.clickUrl,
    this.imageUrl,
    this.uniqueKey,
    this.payload,
    this.buttons,
    this.sound,
    this.mutableContent,
    this.available,
  );
}

/// notification buttons
class NotificationButton {
  final String text;
  final String url;
  final String uniqueKey;

  NotificationButton(this.text, this.url, this.uniqueKey);
}
