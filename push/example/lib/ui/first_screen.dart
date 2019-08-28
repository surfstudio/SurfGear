import 'package:flutter/material.dart';
import 'package:push_demo/domain/message.dart';

const String androidMipMapIcon = "@mipmap/ic_launcher";

class FirstScreen extends StatefulWidget {
  FirstScreen(this.payload);

  final Message payload;

  @override
  FirstScreenState createState() => new FirstScreenState();
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
        title: Text('First notification screen'),
      ),
      body: Placeholder(),
    );
  }
}
