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
