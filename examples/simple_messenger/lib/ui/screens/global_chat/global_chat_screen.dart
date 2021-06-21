import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

import 'package:simple_messenger/data/message.dart';
import 'package:simple_messenger/interactor/message/message_interactor.dart';
import 'package:simple_messenger/ui/screens/global_chat/global_chat_screen_wm.dart';
import 'package:simple_messenger/ui/widgets/message_list_item.dart';

class GlobalChatScreen extends CoreMwwmWidget<GlobalChatScreenWidgetModel> {
  GlobalChatScreen({required String username, Key? key})
      : super(
          key: key,
          widgetModelBuilder: (context) {
            final interactor = context.read<MessageInteractor>();
            final wmDependencies = context.read<WidgetModelDependencies>();

            return GlobalChatScreenWidgetModel(
              wmDependencies,
              username: username,
              messageInteractor: interactor,
            );
          },
        );

  @override
  _GlobalChatScreenState createWidgetState() => _GlobalChatScreenState();
}

class _GlobalChatScreenState
    extends WidgetState<GlobalChatScreen, GlobalChatScreenWidgetModel> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chat Example'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamedStateBuilder<List<Message>>(
                streamedState: wm.messageListState,
                builder: _messageListBuilder,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(controller: wm.messageController),
                    ),
                    IconButton(
                      onPressed: wm.sendMessageAction,
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _messageListBuilder(BuildContext context, List<Message> messages) {
    if (messages.isNotEmpty) {
      final list = ListView.builder(
        controller: wm.scrollController,
        itemCount: messages.length,
        itemBuilder: (_, index) {
          final message = messages[index];

          return MessageListItem(
            message: message,
            isSender: wm.username == message.sender,
          );
        },
      );

      Future<void>.microtask(wm.scrollToEnd);

      return list;
    } else {
      return const Center(
        child: Text('Пусто'),
      );
    }
  }
}
