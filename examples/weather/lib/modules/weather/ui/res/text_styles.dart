import 'package:flutter/material.dart';
import 'package:weather/modules/weather/ui/decorations/shadows.dart';

/// Главные текстовые стили для экрана погоды

final TextStyle hl1Style = TextStyle(
  fontFamily: 'Anton',
  fontSize: 104,
  color: Colors.white,
  letterSpacing: 3,
  shadows: defaultShadow(),
);

final TextStyle hl2Style = TextStyle(
  fontFamily: 'Anton',
  fontSize: 44,
  color: Colors.white,
  shadows: defaultShadow(),
);

final TextStyle hl5StyleBold = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 24,
  color: Colors.white,
  fontWeight: FontWeight.w900,
  shadows: defaultShadow(),
);

final TextStyle hl5Style = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 24,
  color: Colors.white,
  shadows: defaultShadow(),
);
