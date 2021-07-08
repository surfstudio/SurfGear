import 'package:flutter/material.dart';
import 'package:simple_messenger/ui/screens/global_chat/global_chat_screen.dart';

class GlobalChatScreenRoute extends MaterialPageRoute<void> {
  GlobalChatScreenRoute({required String username})
      : super(builder: (context) => GlobalChatScreen(username: username));
}
