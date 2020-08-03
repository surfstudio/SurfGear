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
