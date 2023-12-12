import 'package:flutter/material.dart';

import 'custom_rich_text.dart';

class CustomElevatedButton extends StatelessWidget {
  void Function() onPressed;
  double width;
  double height;
  String text;
  Widget widget;
  CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.text,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(
              const Size(330, 50),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget,
              const SizedBox(
                width: 20,
              ),
              CustomRichText(
                text: text,
                childText: '',
                color: Colors.white54.withOpacity(0.5),
                size: 25,
                fontWeight: FontWeight.w500,
                childTxtColor: Colors.black.withOpacity(0.9),
                childSize: 15,
                childFW: FontWeight.w200,
              ),
            ],
          ),
        ));
  }
}
