import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jitsi_meet/src/jitsi_meet_controller.dart';

const String viewType = 'surfstudio/jitsi_meet';

class JitsiMeet extends StatefulWidget {
  final JitsiMeetViewCreatedCallback onControllerCreated;

  const JitsiMeet({
    Key key,
    @required this.onControllerCreated,
  }) : super(key: key);

  @override
  _JitsiMeetState createState() => _JitsiMeetState();
}

class _JitsiMeetState extends State<JitsiMeet> {
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
        throw Exception("Unsupported TargetPlatform - $defaultTargetPlatform ");
    }
  }

  void _onPlatformViewCreated(int id) {
    widget.onControllerCreated?.call(JitsiMeetController.init(id));
  }
}
