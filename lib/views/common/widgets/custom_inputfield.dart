import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final bool? obescureText;
  final TextEditingController controller;
  const CustomInputField(
      {super.key,
      required this.hintText,
      this.obescureText,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obescureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 16),
        filled: true,
        fillColor: const Color.fromARGB(255, 109, 115, 122).withOpacity(0.1),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 19, 19, 19), width: 2.0)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 10, 1, 1).withOpacity(0.8),
                width: 2.0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
                color: Color.fromARGB(0, 22, 21, 21), width: 2.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 52, 50, 50), width: 2.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: Colors.transparent, width: 2.0)),
      ),
      controller: controller,
      cursorHeight: 25,
      style: TextStyle(
          color: const Color.fromARGB(255, 4, 31, 54).withOpacity(0.8),
          fontWeight: FontWeight.w500),
    );
  }
}
