import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixText;
  final bool? enabled;
  final Widget? suffixIcon;
  const PriceInputWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      this.enabled,
      required this.prefixText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // color: Colors.red,
      height: 50,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black.withOpacity(0.7)),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          prefixText: '$prefixText\$',
          suffixIcon: suffixIcon,
          enabled: enabled ?? true,
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(
              color: Colors.blue, // Border color
              width: 2.0, // Border width
            ),
          ),
        ),
      ),
    );
  }
}
