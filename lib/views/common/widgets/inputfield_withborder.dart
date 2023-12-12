import 'package:flutter/material.dart';

class InputFieldWithBorder extends StatelessWidget {
  final String hintText;
  final String? prefixText;
  final bool? obescureText;
  final bool? enabled;
  final bool? paddingEnabled;

  final int? maxlines;
  final double? height;
  final TextInputType? type;
  final Widget? suffixIcon;
  String? Function(String?)? validator;
  final TextEditingController controller;
  InputFieldWithBorder(
      {super.key,
      required this.hintText,
      this.obescureText,
      required this.controller,
      this.maxlines = 1,
      this.validator,
      this.prefixText,
      this.suffixIcon,
      this.type = TextInputType.text,
      this.height,
      this.enabled,
      this.paddingEnabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingEnabled == null
          ? const EdgeInsets.all(16.0)
          : const EdgeInsets.all(0),
      child: Center(
        child: Container(
          alignment: Alignment.bottomLeft,
          height: height ?? 50,
          child: TextFormField(
            controller: controller,
            maxLines: maxlines,
            validator: validator,
            style: TextStyle(color: Colors.black.withOpacity(0.7)),
            keyboardType: type,
            obscureText: obescureText ?? false,
            decoration: InputDecoration(
              prefixText: prefixText ?? '',
              enabled: enabled ?? true,
              fillColor: Colors.white.withOpacity(0.8),
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
              suffixIcon: suffixIcon,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 230, 238, 245), // Border color
                  width: 1.0, // Border width
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
