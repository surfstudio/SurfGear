import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Webpage footer
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
