import 'package:flutter/material.dart';

import '../domain/message.dart';

const String androidMipMapIcon = '@mipmap/ic_launcher';

class SecondScreen extends StatefulWidget {
  const SecondScreen(this.payload, {Key key}) : super(key: key);

  final Message payload;

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second notification screen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Incoming message'),
            Text('Title : ${widget.payload.title}'),
            Text('Body: ${widget.payload.body}'),
          ],
        ),
      ),
    );
  }
}
