import 'package:flutter/material.dart';
import 'package:simple_messenger/data/message.dart';

class MessageListItem extends StatelessWidget {
  final Message message;
  final bool isSender;

  const MessageListItem({
    required this.message,
    required this.isSender,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = message.sendTime;
    const space = SizedBox(height: 8);

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(message.sender),
              space,
              Text(message.content),
              space,
              Text('${time.hour}:${time.minute}'),
            ],
          ),
        ),
      ),
    );
  }
}
