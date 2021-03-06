import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:simple_messenger/ui/screens/choose_name/pick_name_screen_wm.dart';
import 'package:simple_messenger/ui/screens/global_chat/global_chat_screen_route.dart';

class PickNameScreen extends CoreMwwmWidget<PickNameScreenWidgetModel> {
  PickNameScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: (context) {
            final wmDependencies = context.read<WidgetModelDependencies>();
            return PickNameScreenWidgetModel(wmDependencies);
          },
        );

  @override
  _PickNameScreenState createWidgetState() => _PickNameScreenState();
}

class _PickNameScreenState
    extends WidgetState<PickNameScreen, PickNameScreenWidgetModel> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chat Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Введите ваше имя!'),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: wm.nameController,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  GlobalChatScreenRoute(username: wm.nameController.text),
                ),
                child: const Text('Подтвердить'),
              ),
            ],
          ),
        ),
      );
}
