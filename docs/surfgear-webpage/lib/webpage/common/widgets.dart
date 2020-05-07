import 'package:flutter/material.dart';
import 'dart:html' as html;

class Clickable extends StatelessWidget {
  static final appContainer =
      html.window.document.getElementById('app-container');

  final VoidCallback onClick;
  final Widget child;

  Clickable({
    Key key,
    @required this.child,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) => appContainer.style.cursor = 'pointer',
      onExit: (_) => appContainer.style.cursor = 'default',
      child: GestureDetector(onTap: onClick, child: child),
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
    return Clickable(
      onClick: onPressed,
      child: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => hovering = true),
            onExit: (_) => setState(() => hovering = false),
            child: buttonBuilder(context, hovering),
          );
        },
      ),
    );
  }
}
