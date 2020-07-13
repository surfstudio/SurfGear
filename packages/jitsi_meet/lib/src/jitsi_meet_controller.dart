import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// Callback controller created
typedef void JitsiMeetViewCreatedCallback(JitsiMeetController controller);

/// Channels and methods names
const String CHANNEL_NAME = "surf_jitsi_meet_";
const String LEAVE_ROOM = "leave_room";
const String JOIN_ROOM = "join_room";
const String SET_USER = "set_user";
const String SET_FEATURE_FLAG = "set_feature_flag";

/// callbacks
const String ON_JOINED = "on_joined";
const String ON_WILL_JOIN = "on_will_join";
const String ON_TERMINATED = "on_terminated";

/// variables
const String ROOM = "room";
const String AUDIO_MUTED = "audioMuted";
const String VIDEO_MUTED = "videoMuted";
const String AUDIO_ONLY = "audioOnly";
const String USERNAME = "displayName";
const String EMAIL = "email";
const String AVATAR_URL = "avatarURL";
const String FLAG = "flag";
const String FLAG_VALUE = "flag_value";

/// Controller for [JitsiMeetWidget]
class JitsiMeetController {
  /// User joined to the room
  final VoidCallback onJoined;

  /// Room found/created but user not joined
  final VoidCallback onWillJoin;

  /// Call terminated by user or error
  final VoidCallback onTerminated;

  MethodChannel _channel;
  String _currentRoom;

  JitsiMeetController.init(
    int id,
    this.onWillJoin,
    this.onJoined,
    this.onTerminated,
  ) {
    _channel = MethodChannel('$CHANNEL_NAME$id');
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  /// leave current room
  /// does noting if user not in room
  Future<void> leaveRoom() async {
    if (_currentRoom != null) {
      _currentRoom = null;
      await _channel.invokeMethod<void>(LEAVE_ROOM);
    }
  }

  /// join/create room with specified name and parameters
  Future<void> joinRoom(
    String room, {
    bool audioMuted,
    bool videoMuted,
    bool audioOnly,
  }) async {
    await _channel.invokeMethod<void>(JOIN_ROOM, <String, dynamic>{
      ROOM: room,
      AUDIO_MUTED: audioMuted,
      VIDEO_MUTED: videoMuted,
      AUDIO_ONLY: audioOnly,
    });
  }

  /// add information about user
  Future<void> setUserInfo(
    String username, {
    String email,
    String avatarURL,
  }) async {
    await _channel.invokeMethod<void>(SET_USER, <String, dynamic>{
      USERNAME: username,
      EMAIL: email,
      AVATAR_URL: avatarURL,
    });
  }

  /// Set enabled state to feature
  ///
  /// features of current Jitsi plugin version
  /// for more feature flags update jitsi meet plugin version
  /// https://github.com/jitsi/jitsi-meet/blob/e5b563ba46f168b622bf4ccdae1695b438bc7487/react/features/base/flags/constants.js
  Future<void> setFeatureFlag(String flag, bool value) async {
    await _channel.invokeMethod<void>(SET_FEATURE_FLAG, <String, dynamic>{
      FLAG: flag,
      FLAG_VALUE: value,
    });
  }

  Future<void> _methodCallHandler(MethodCall call) {
    switch (call.method) {
      case ON_JOINED:
        onJoined?.call();
        break;
      case ON_WILL_JOIN:
        onWillJoin?.call();
        break;
      case ON_TERMINATED:
        onTerminated?.call();
        break;
    }
  }
}
