import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final rubikBase = GoogleFonts.rubik();
final sourceCodeProBase = GoogleFonts.sourceCodePro();

final rubickBlack = rubikBase.copyWith(
  color: titleTextColor,
);
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

final rubikBlack300 = rubickBlack.copyWith(
  fontWeight: FontWeight.w300,
);

final rubikBlack300_28 = rubikBlack300.copyWith(
  fontSize: 28.0,
);

final rubikBlack300_38 = rubikBlack300.copyWith(
  fontSize: 38.0,
);
