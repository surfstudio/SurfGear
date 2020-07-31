import 'package:flutter/material.dart';

import '../domain/message.dart';

const String androidMipMapIcon = '@mipmap/ic_launcher';

class FirstScreen extends StatefulWidget {
  const FirstScreen(this.payload, {Key key}) : super(key: key);

  final Message payload;

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First notification screen'),
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
