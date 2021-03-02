import 'package:example/ui/base/default_dialog_controller.dart';
import 'package:example/ui/base/default_message_controller.dart';
import 'package:example/ui/screen/home_screen/home_dialog_owner.dart';
import 'package:example/ui/widgets/example_dialog.dart';
import 'package:flutter/material.dart';
import 'package:surf_controllers/surf_controllers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  DialogController _dialogController;
  MessageController _messageController;

  @override
  void initState() {
    super.initState();
    _dialogController = DefaultDialogController.from(
      context,
      dialogOwner: HomeDialogOwner(),
    );
    _messageController = DefaultMessageController(_scaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: _showExampleDialog,
              child: Text('Show example dialog'),
            ),
            FlatButton(
              onPressed: _showExampleMessage,
              child: Text('Show message'),
            ),
            FlatButton(
              onPressed: () => _showExampleMessage(MsgType.error),
              child: Text('Show error message'),
            ),
          ],
        ),
      ),
    );
  }

  void _showExampleDialog() {
    _dialogController.showModalSheet(
      ExampleDialogType.text,
      data: ExampleDialogData(
        title: 'Example title',
        subtitle: 'Example subtitle',
      ),
    );
  }

  void _showExampleMessage([MsgType type = MsgType.common]) {
    _messageController.show(msg: 'Example message', msgType: type);
  }
}
