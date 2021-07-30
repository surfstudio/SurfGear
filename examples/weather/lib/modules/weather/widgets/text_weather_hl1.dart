import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/modules/weather/decorations/shadows.dart';

class TextWeatherHL1 extends StatelessWidget {
  const TextWeatherHL1({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.anton(
        fontSize: 104,
        color: Colors.white,
        letterSpacing: 3,
        shadows: defaultShadow(),
      ),
    );
  }
}
