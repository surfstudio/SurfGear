import 'package:flutter/material.dart';
import 'global_chat_screen.dart';

class GlobalChatScreenRoute extends MaterialPageRoute<void> {
  GlobalChatScreenRoute({required String username})
      : super(builder: (context) => GlobalChatScreen(username: username));
}
