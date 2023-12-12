import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      behavior: SnackBarBehavior
          .floating, // Duration for how long the Snackbar is displayed
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 80,
          left: 80),
    ),
  );
}
