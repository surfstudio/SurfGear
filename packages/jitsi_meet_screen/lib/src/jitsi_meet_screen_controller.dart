import 'package:flutter/services.dart';

const String CHANNEL_NAME = "surf_jitsi_meet_screen";

/// Methods
const String JOIN = "join";

class JitsiMeetScreenController {
  static const MethodChannel _channel = const MethodChannel(CHANNEL_NAME);

  void join() {
    _channel.invokeMethod(JOIN);
  }
}
