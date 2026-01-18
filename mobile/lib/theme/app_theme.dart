import "package:flutter/material.dart";

class AppColors {
  static const navy = Color(0xFF0A2540);
  static const electric = Color(0xFF1DA1F2);
  static const lime = Color(0xFFA3E635);
  static const mist = Color(0xFFF4F7FB);
  static const ink = Color(0xFF0B1222);
  static const ghanaRed = Color(0xFFCE1126);
  static const ghanaGold = Color(0xFFFCD116);
  static const ghanaGreen = Color(0xFF006B3F);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.electric,
      primary: AppColors.electric,
      secondary: AppColors.lime,
      background: AppColors.mist,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.mist,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.mist,
      foregroundColor: AppColors.ink,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );
}
