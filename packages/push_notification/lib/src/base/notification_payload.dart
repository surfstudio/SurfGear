/// notification base payload data
abstract class NotificationPayload {
  NotificationPayload(
    this.messageData,
    this.title,
    this.body,
  );

  /// original message
  final Map<String, dynamic> messageData;

  /// field required to show notification
  final String title;
  final String body;
}
