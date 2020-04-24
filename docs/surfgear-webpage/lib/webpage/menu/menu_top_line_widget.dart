import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Меню в виде линии сверху экрана
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=13%3A12
class MenuTopLineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.indigo,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Link 1"),
          SizedBox(
            width: 200.0,
          ),
          Text("Link 2"),
          SizedBox(
            width: 200.0,
          ),
          Text("Link 3"),
        ],
      ),
    );
  }
}
