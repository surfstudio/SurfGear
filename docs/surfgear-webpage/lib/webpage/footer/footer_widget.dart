import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Подвал странички
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=13%3A12
class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),
      child: Column(
        children: [
          Text("footer"),
          RaisedButton(
            onPressed: () {},
            child: Text("смотреть"),
          ),
        ],
      ),
    );
  }
}
