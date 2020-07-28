import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:jitsi_meet_screen/src/jitsi_meet_exceptions.dart';

const String channelName = 'surf_jitsi_meet_screen';

/// Methods
const String leaveRoomMethod = 'leave_room';
const String joinRoomMethod = 'join_room';
const String setUserMethod = 'set_user';
const String setFeatureFlagMethod = 'set_feature_flag';

/// callbacks
const String onJoinedCallback = 'on_joined';
const String onWillJoinCallback = 'on_will_join';
const String onTerminatedCallback = 'on_terminated';

/// variables
const String roomVariable = 'room';
const String audioMutedVariable = 'audioMuted';
const String videoMutedVariable = 'videoMuted';
const String audioOnlyVariable = 'audioOnly';
const String userNameVariable = 'displayName';
const String emailVariable = 'email';
const String avatarUrlVariable = 'avatarURL';
const String flagVariable = 'flag';
const String flagValueVariable = 'flag_value';

class JitsiMeetScreenController {
  JitsiMeetScreenController(
    this.onJoined,
    this.onWillJoin,
    this.onTerminated,
  ) : _channel = const MethodChannel(channelName) {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  /// User joined to the room
  final VoidCallback onJoined;

  /// Room found/created but user not joined
  final VoidCallback onWillJoin;

  /// Call terminated by user or error
  final VoidCallback onTerminated;

  final MethodChannel _channel;
  String _currentRoom;

  /// leave current room
  /// does noting if user not in room
  Future<void> leaveRoom() async {
    if (_currentRoom != null) {
      _currentRoom = null;
      await _channel.invokeMethod<void>(leaveRoomMethod);
    }
  }

  /// join/create room with specified name and parameters
  Future<void> joinRoom(
    String room, {
    bool audioMuted,
    bool videoMuted,
    bool audioOnly,
  }) async {
    if (_currentRoom != null) throw CallAlreadyStartedException();
    _currentRoom = room;
    await _channel.invokeMethod<void>(joinRoomMethod, <String, dynamic>{
      roomVariable: room,
      audioMutedVariable: audioMuted,
      videoMutedVariable: videoMuted,
      audioOnlyVariable: audioOnly,
    });
  }

  /// add information about user
  Future<void> setUserInfo(
    String username, {
    String email,
    String avatarURL,
  }) async {
    await _channel.invokeMethod<void>(setUserMethod, <String, dynamic>{
      userNameVariable: username,
      emailVariable: email,
      avatarUrlVariable: avatarURL,
    });
  }

  /// Set enabled state to feature
  ///
  /// features of current Jitsi plugin version
  /// for more feature flags update jitsi meet plugin version
  /// https://github.com/jitsi/jitsi-meet/blob/e5b563ba46f168b622bf4ccdae1695b438bc7487/react/features/base/flags/constants.js
  Future<void> setFeatureFlag(
    String flag, {
    bool value,
  }) async {
    await _channel.invokeMethod<void>(setFeatureFlagMethod, <String, dynamic>{
      flagVariable: flag,
      flagValueVariable: value,
    });
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case onJoinedCallback:
        onJoined?.call();
        break;
      case onWillJoinCallback:
        onWillJoin?.call();
        break;
      case onTerminatedCallback:
        _currentRoom = null;
        onTerminated?.call();
        break;
    }
  }
}
