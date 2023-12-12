import 'package:flutter/material.dart';

import '../styles/text_style.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final String childText;
  final Color color;
  final Color childTxtColor;
  final double size;
  final double childSize;
  final FontWeight fontWeight;
  final FontWeight childFW;
  final bool? decoration;
  const CustomRichText(
      {super.key,
      required this.text,
      required this.childText,
      required this.color,
      required this.size,
      required this.fontWeight,
      required this.childTxtColor,
      required this.childSize,
      required this.childFW,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: text,
            style: commonTextStyles(color, size, fontWeight, false),
            children: [
              TextSpan(
                  text: childText,
                  style: commonTextStyles(
                      childTxtColor, childSize, childFW, decoration ?? true))
            ]));
  }
}
