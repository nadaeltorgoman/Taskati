import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle title(BuildContext context, {
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.bold,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle subtitle(BuildContext context, {
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle body(BuildContext context, {
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle button(BuildContext context, {
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.bold,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle caption(BuildContext context, {
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }
}
