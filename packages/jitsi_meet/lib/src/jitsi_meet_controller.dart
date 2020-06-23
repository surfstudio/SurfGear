import 'package:flutter/services.dart';

/// Callback controller created
typedef void JitsiMeetViewCreatedCallback(JitsiMeetController controller);

/// Channels and methods names
const String CHANNEL_NAME = "surf_jitsi_meet_";

class JitsiMeetController {
  MethodChannel _channel;

  JitsiMeetController.init(int id) {
    _channel =  new MethodChannel('$CHANNEL_NAME$id');
  }
}