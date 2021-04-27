import 'package:example/ui/base/default_dialog_controller.dart';
import 'package:example/ui/base/default_message_controller.dart';
import 'package:example/ui/screen/home_screen/home_dialog_owner.dart';
import 'package:example/ui/widgets/example_dialog.dart';
import 'package:flutter/material.dart';
import 'package:surf_controllers/surf_controllers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late DialogController _dialogController;
  late MessageController _messageController;

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
            TextButton(
              onPressed: _showExampleDialog,
              child: const Text('Show example dialog'),
            ),
            TextButton(
              onPressed: _showExampleMessage,
              child: const Text('Show message'),
            ),
            TextButton(
              onPressed: () => _showExampleMessage(MsgType.error),
              child: const Text('Show error message'),
            ),
          ],
        ),
      ),
    );
  }

  void _showExampleDialog() {
    _dialogController.showModalSheet<void>(
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
