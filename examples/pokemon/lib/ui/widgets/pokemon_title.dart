import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// Widget for animated title
class PokemonTitle extends StatelessWidget {
  final String title;

  PokemonTitle(this.title);

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: true,
      animatedTexts: [
        ColorizeAnimatedText(
          title,
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
        )
      ],
    );
  }
}
