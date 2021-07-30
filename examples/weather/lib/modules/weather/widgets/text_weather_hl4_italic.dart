import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/modules/weather/decorations/shadows.dart';

class TextWeatherHL4Italic extends StatelessWidget {
  const TextWeatherHL4Italic({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 34,
        color: Colors.white,
        fontWeight: FontWeight.w900,
        shadows: defaultShadow(),
      ),
    );
  }
}
