import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import '../../../data/message.dart';

import '../../../interactor/message/message_interactor.dart';

class GlobalChatScreenWidgetModel extends WidgetModel {
  GlobalChatScreenWidgetModel(
    WidgetModelDependencies baseDependencies, {
    required this.username,
    required MessageInteractor messageInteractor,
  })  : _messageInteractor = messageInteractor,
        super(baseDependencies);

  final String username;
  final MessageInteractor _messageInteractor;

  final messageController = TextEditingController();
  final scrollController = ScrollController();

  final sendMessageAction = VoidAction();
  final messageListState = StreamedState<List<Message>>([]);

  @override
  void onBind() {
    super.onBind();
    subscribe<void>(sendMessageAction.stream, (_) => _sendMessage());
    subscribe<List<Message>>(_messageInteractor.getMessages(), _viewMessages);
  }

  void scrollToEnd() =>
      scrollController.jumpTo(scrollController.position.maxScrollExtent);

  void _sendMessage() {
    _messageInteractor.sendMessage(
      Message(
        sender: username,
        content: messageController.text,
        sendTime: DateTime.now(),
      ),
    );
    messageController.clear();
  }

  void _viewMessages(List<Message> messages) {
    messageListState.accept(messages);
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
