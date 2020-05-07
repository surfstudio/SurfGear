import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle pageHeadlineTextStyle({
  Color color = textColor,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 42.0,
}) {
  return GoogleFonts.rubik(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
  );
}

TextStyle headlineTextStyle({
  Color color = textColor,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 38.0,
}) {
  return GoogleFonts.rubik(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
  );
}

TextStyle subtitleTextStyle({
  Color color = textColor,
  FontWeight fontWeight = FontWeight.w300,
  double fontSize = 36.0,
}) {
  return GoogleFonts.rubik(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
  );
}

TextStyle bodyTextStyle({
  Color color = textColor,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 22.0,
}) {
  return GoogleFonts.raleway(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
  );
}

TextStyle buttonTextStyle({
  Color color = textColor,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 18.0,
  double letterSpacing = 1.0,
  TextDecoration decoration = TextDecoration.none,
}) {
  return GoogleFonts.comfortaa(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    letterSpacing: letterSpacing,
    decoration: decoration,
  );
}
