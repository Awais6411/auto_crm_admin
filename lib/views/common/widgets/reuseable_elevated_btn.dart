import 'package:flutter/material.dart';

import 'custom_rich_text.dart';

class ReuseAbleElevatedButton extends StatelessWidget {
  String text;
  double width;
  double height;
  void Function()? onPressed;
  ReuseAbleElevatedButton({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(
          Size(width,
              height), // Replace yourDesiredWidth and yourDesiredHeight with your preferred values
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 53, 75, 152).withOpacity(0.8),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      onPressed: onPressed,
      child: CustomRichText(
        text: text,
        childText: '',
        color: Colors.white54.withOpacity(0.6),
        size: 25,
        fontWeight: FontWeight.w500,
        childTxtColor: Colors.black.withOpacity(0.9),
        childSize: 15,
        childFW: FontWeight.w200,
      ),
    );
  }
}
