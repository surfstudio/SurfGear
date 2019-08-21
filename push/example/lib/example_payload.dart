import 'package:push/push.dart';

class ExamplePayload extends BaseNotificationPayload {
  final int payloadInt;
  final String payloadString;

  ExamplePayload(
    this.payloadInt,
    this.payloadString,
  );
}
