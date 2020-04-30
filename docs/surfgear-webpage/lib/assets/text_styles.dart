import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// base
final rubikBase = GoogleFonts.rubik();
final sourceCodeProBase = GoogleFonts.sourceCodePro();
final ralewayBase = TextStyle(fontFamily: "Raleway");

/// black
final rubickBlack = rubikBase.copyWith(
  color: titleTextColor,
);

final ralewayBlack = ralewayBase.copyWith(
  color: titleTextColor,
);

/// normal
final rubikBlackNormal = rubickBlack.copyWith(
  fontWeight: FontWeight.normal,
);

final rubikBlackNormal22 = rubikBlackNormal.copyWith(
  fontSize: 22.0,
);

final rubikBlackNormal28 = rubikBlackNormal.copyWith(
  fontSize: 28.0,
);
final rubikBlackNormal36 = rubikBlackNormal.copyWith(
  fontSize: 36.0,
);
final rubikBlackNormal38 = rubikBlackNormal.copyWith(
  fontSize: 38.0,
);

final ralewayBlackNormal = ralewayBlack.copyWith(
  fontWeight: FontWeight.normal,
);

final ralewayBlackNormal22 = ralewayBlack.copyWith(
  fontSize: 22,
);

///w300
final rubikBlack300 = rubickBlack.copyWith(
  fontWeight: FontWeight.w300,
);

final rubikBlack300_28 = rubikBlack300.copyWith(
  fontSize: 28.0,
);

final rubikBlack300_36 = rubikBlack300.copyWith(
  fontSize: 36.0,
);

final rubikBlack300_38 = rubikBlack300.copyWith(
  fontSize: 38.0,
);
