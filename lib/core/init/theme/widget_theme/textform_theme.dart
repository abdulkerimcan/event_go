import 'package:eventgo/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();

  static InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstants.primaryColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: ColorConstants.primaryColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))),
  );
}
