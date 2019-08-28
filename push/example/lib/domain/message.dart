import 'package:push/push.dart';

class Message extends BaseNotificationPayload {
  int extraInt;
  double extraDouble;

  @override
  void extractDataFromMap(Map<String, dynamic> map) {
    super.extractDataFromMap(map);
    print('extractDataFromMap: $map');
    extraInt = map['extraInt'] ?? 0;
    extraDouble = map['extraDouble'] ?? 0.0;
  }
}
