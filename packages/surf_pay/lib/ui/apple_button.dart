import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppleButton extends StatelessWidget {
  VoidCallback onTap;

  AppleButton(this.onTap);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      color: Colors.blue,
      child: Text("pay"),
    );
  }
}
