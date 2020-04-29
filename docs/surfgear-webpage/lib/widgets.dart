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

class WebButton extends StatelessWidget {
  final Widget Function(BuildContext context, bool isHovering) buttonBuilder;
  final VoidCallback onPressed;

  WebButton({
    Key key,
    @required this.buttonBuilder,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hovering = false;
    return CursorOnHoverWidget(
      child: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => hovering = true),
            onExit: (_) => setState(() => hovering = false),
            child: GestureDetector(
              onTap: onPressed,
              child: buttonBuilder(context, hovering),
            ),
          );
        },
      ),
    );
  }
}
