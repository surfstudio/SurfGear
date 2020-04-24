import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Тело странички
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=13%3A12
class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text("body"),
        ],
      ),
    );
  }
}
