import 'package:flutter/material.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:flutter_template/ui/res/text_styles.dart';

/// Основные стили
// todo Настройка темы приложения
final themeData = ThemeData(
    primaryColor: colorAccent,
    accentColor: btnColor,
    accentColorBrightness: Brightness.light,
    backgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      color: appBarColor,
      brightness: Brightness.light,
      elevation: 4.0,
    ),
    brightness: Brightness.light,
    buttonColor: btnColor,
    errorColor: colorError,
    scaffoldBackgroundColor: backgroundColor,
    hintColor: hintColor,
    textTheme: const TextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: colorError),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: colorAccent,
          width: 2.0,
        ),
      ),
      hintStyle: textRegular16Secondary,
      prefixStyle: textRegular16,
    ),
    cursorColor: colorAccent,
    textSelectionHandleColor: colorAccent);
