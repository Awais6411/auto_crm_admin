import 'package:flutter/material.dart';

class AppConstants {
  static const String ADMIN_LOGGEDIN_KEY = "adminLoggedin";
  static const String USER_LOGGEDIN_KEY = "userLoggedin";
  static const String ENTRYPOINT_KEY = "entrypoint";
  static const String ADMIN_TOKEN_KEY = "adminToken";
  static const String USER_TOKEN_KEY = "userToken";
  static const String USER_ID_KEY = "userId";
  static const String IS_FIRST_TIME_KEY = "firstTime";

  static void showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        duration: const Duration(seconds: 1),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 80,
            left: 80),
      ),
    );
  }
}
