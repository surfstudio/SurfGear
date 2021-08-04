import 'package:flutter/material.dart';

/// тени для текстов на экране погоды
List<Shadow> defaultShadow() {
  return [
    Shadow(
      color: Colors.black,
      blurRadius: 1,
      offset: Offset(1, 1),
    )
  ];
}
