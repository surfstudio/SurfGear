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

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jitsi_meet/src/jitsi_meet_controller.dart';

const String viewType = 'surfstudio/jitsi_meet';

/// Widget with native JitsiView
class JitsiMeetWidget extends StatefulWidget {
  const JitsiMeetWidget({
    @required this.onControllerCreated,
    Key key,
    this.onJoined,
    this.onWillJoin,
    this.onTerminated,
  }) : super(key: key);

  /// callnack with controller of current widget
  final JitsiMeetViewCreatedCallback onControllerCreated;

  /// User join to the room
  final VoidCallback onJoined;

  /// Jitsi find room but user not connected yet
  final VoidCallback onWillJoin;

  /// Call ended by user or error
  ///
  /// Error with connection
  /// User leave room
  final VoidCallback onTerminated;

  @override
  _JitsiMeetWidgetState createState() => _JitsiMeetWidgetState();
}

class _JitsiMeetWidgetState extends State<JitsiMeetWidget> {
  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: viewType,
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw Exception('Unsupported TargetPlatform - $defaultTargetPlatform ');
    }
  }

  void _onPlatformViewCreated(int id) {
    widget.onControllerCreated?.call(
      JitsiMeetController.init(
        id,
        widget.onWillJoin,
        widget.onJoined,
        widget.onTerminated,
      ),
    );
  }
}
