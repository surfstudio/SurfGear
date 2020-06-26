import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// Callback controller created
typedef void JitsiMeetViewCreatedCallback(JitsiMeetController controller);

/// Channels and methods names
const String CHANNEL_NAME = "surf_jitsi_meet_";
const String LEAVE_ROOM = "leave_room";
const String JOIN_ROOM = "join_room";
const String SET_USER = "set_user";

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
    _channel = new MethodChannel('$CHANNEL_NAME$id');
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
