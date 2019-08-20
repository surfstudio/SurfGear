import 'package:push/push.dart';

class ExampleStrategy extends PushHandleStrategy {
  @override
  void handleMessage(
      Map<String, dynamic> message, MessageHandlerType handlerType) {
    print("on $handlerType message: $message");
  }
}
