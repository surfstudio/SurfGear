import 'package:flutter/material.dart';
import 'dart:html' as html;

class CursorOnHoverWidget extends StatelessWidget {
  static final appContainer =
      html.window.document.getElementById('app-container');

  final Widget child;

  CursorOnHoverWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) => appContainer.style.cursor = 'pointer',
      onExit: (_) => appContainer.style.cursor = 'default',
      child: child,
    );
  }
}
