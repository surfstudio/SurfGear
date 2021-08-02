import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:weather/modules/weather/ui/decorations/shadows.dart';

final TextStyle hl1Style = GoogleFonts.anton(
  fontSize: 104,
  color: Colors.white,
  letterSpacing: 3,
  shadows: defaultShadow(),
);

final TextStyle hl2Style = GoogleFonts.anton(
  fontSize: 44,
  color: Colors.white,
  shadows: defaultShadow(),
);

final TextStyle hl5StyleBold = GoogleFonts.roboto(
  fontSize: 24,
  color: Colors.white,
  fontWeight: FontWeight.w900,
  shadows: defaultShadow(),
);

final TextStyle hl5Style = GoogleFonts.roboto(
  fontSize: 24,
  color: Colors.white,
  shadows: defaultShadow(),
);
