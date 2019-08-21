import 'package:push/push.dart';
import 'package:push_demo/example_payload.dart';

class ExampleStrategy extends BasePushHandleStrategy<ExamplePayload> {
  @override
  void extractPayloadFromMap(Map<String, dynamic> map) {
    payload = ExamplePayload(
      map['payloadInt'],
      map['payloadString'],
    );
  }

  @override
  void onTapNotification() {
    print('on tap notification');
  }
}
