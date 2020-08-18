// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// Callback controller created
typedef JitsiMeetViewCreatedCallback = void Function(JitsiMeetController);

/// Channels and methods names
const String channelName = 'surf_jitsi_meet_';
const String leaveRoomMethod = 'leave_room';
const String joinRoomMethod = 'join_room';
const String setUserMethod = 'set_user';
const String setFeatureFlagMethod = 'set_feature_flag';

/// callbacks
const String onJoinedCallback = 'on_joined';
const String onWellJoined = 'on_will_join';
const String onTerminatedCallback = 'on_terminated';

/// variables
const String roomVariable = 'room';
const String audioMutedVariable = 'audioMuted';
const String videoMutedVariable = 'videoMuted';
const String audioOnlyVariable = 'audioOnly';
const String userNameVariable = 'displayName';
const String emailVariable = 'email';
const String avatarUrl = 'avatarURL';
const String flagVariable = 'flag';
const String flagValueVariable = 'flag_value';

/// Controller for JitsiMeetWidget
class JitsiMeetController {
  JitsiMeetController.init(
    int id,
    this.onWillJoin,
    this.onJoined,
    this.onTerminated,
  ) {
    _channel = MethodChannel('$channelName$id')
      ..setMethodCallHandler(_methodCallHandler);
  }

  /// User joined to the room
  final VoidCallback onJoined;

  /// Room found/created but user not joined
  final VoidCallback onWillJoin;

  /// Call terminated by user or error
  final VoidCallback onTerminated;

  MethodChannel _channel;
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
      avatarUrl: avatarURL,
    });
  }

  /// Set enabled state to feature
  ///
  /// features of current Jitsi plugin version
  /// for more feature flags update jitsi meet plugin version
  /// https://github.com/jitsi/jitsi-meet/blob/e5b563ba46f168b622bf4ccdae1695b438bc7487/react/features/base/flags/constants.js
  Future<void> setFeatureFlag(String flag, {bool value}) async {
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
      case onWellJoined:
        onWillJoin?.call();
        break;
      case onTerminatedCallback:
        onTerminated?.call();
        break;
    }
  }
}
