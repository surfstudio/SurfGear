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
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JitsiScreen extends StatelessWidget {
  const JitsiScreen({Key key, this.room}) : super(key: key);

  final String room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: JitsiMeetWidget(
          onControllerCreated: _onControllerCreated,
          onTerminated: () => _onTerminated(context),
          // ignore: avoid_print
          onJoined: () => print('User join'),
          // ignore: avoid_print
          onWillJoin: () => print('Room found'),
        ),
      ),
    );
  }

  void _onControllerCreated(JitsiMeetController controller) {
    controller.joinRoom(room);
  }

  void _onTerminated(BuildContext context) {
    Navigator.pop(context);
  }
}
