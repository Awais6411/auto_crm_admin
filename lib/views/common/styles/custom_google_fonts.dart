import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customGoolgeFonts(
    Color color, FontWeight fontWeight, double fontSize) {
  return GoogleFonts.aleo(
    textStyle:
        TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
  );
}
