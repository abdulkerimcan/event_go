import 'package:eventgo/core/theme/widget_theme/textform_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: const Color(0xff5265FF),
              shape: const StadiumBorder())),
      inputDecorationTheme: TextFormFieldTheme.inputDecorationTheme,
      textTheme: ThemeData.light().textTheme.copyWith(
            labelLarge: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            labelMedium: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ));
}
