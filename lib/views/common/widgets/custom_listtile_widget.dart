import 'package:flutter/material.dart';

import '../styles/custom_google_fonts.dart';

class CustomListTileWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color? color;
  final void Function()? onTap;
  const CustomListTileWidget({
    Key? key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.asset(
          iconPath,
          fit: BoxFit.cover,
          height: 38,
          width: 38,
          // color: const Color.fromARGB(255, 4, 136, 9),
          color: color,
        ),
        title: Text(text,
            style: customGoolgeFonts(
                const Color.fromARGB(
                  255,
                  1,
                  102,
                  161,
                ),
                FontWeight.bold,
                25)),
        onTap: onTap);
  }
}
