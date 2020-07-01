import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  VoidCallback onTap;

  GoogleButton(this.onTap);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: Colors.blue,
      child: Text("pay"),
    );
  }
}
