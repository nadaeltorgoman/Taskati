import 'package:flutter/material.dart';
import 'package:taskati/core/utils/app_colors.dart';

class AppThemes {
  static get lightTheme => ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      titleTextStyle: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'poppins',
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.black,
      error: AppColors.redColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: AppColors.darkGray, fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
    ),
  );

  static get darkTheme => ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'poppins',
      ),
    ),
    scaffoldBackgroundColor: AppColors.darkColor,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.white,
      error: AppColors.redColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onError: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: AppColors.darkGray, fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
    ),
  );
}
