import 'package:flutter/material.dart';

TextStyle commonTextStyles(
    Color colors, double fontSize, FontWeight fontWeight, bool decoration) {
  return TextStyle(
    color: colors,
    fontSize: fontSize,
    fontWeight: fontWeight,
    decoration:
        decoration == true ? TextDecoration.underline : TextDecoration.none,
  );
}
