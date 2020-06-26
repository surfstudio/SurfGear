import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JitsiScreen extends StatelessWidget {
  final String room;

  const JitsiScreen({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JitsiMeetWidget(
      onControllerCreated: _onControllerCreated,
      onTerminated: () => _onTerminated(context),
      onJoined: () => print("User join"),
      onWillJoin: () => print("Room found"),
    );
  }

  void _onControllerCreated(JitsiMeetController controller) {
    controller.setUserInfo("Example user");
    controller.joinRoom(room);
  }

  void _onTerminated(BuildContext context) {
    Navigator.pop(context);
  }
}
