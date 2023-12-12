import 'dart:async';
import 'package:auto_crm_admin/views/ui/auth/login.dart';
import 'package:flutter/material.dart';

import 'views/ui/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserLogin(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 70, 79, 251),
            Color.fromARGB(255, 19, 249, 246)
          ], // Replace with your desired colors
          begin: Alignment.topLeft, // Adjust the starting point
          end: Alignment.bottomRight, // Adjust the ending point
        )),
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   colors: [Colors.blue, Colors.red], // Replace with your desired colors
        //   begin: Alignment.topLeft, // Adjust the starting point
        //   end: Alignment.bottomRight, // Adjust the ending point
        // )),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   "assets/images/lg_icon.png",
            //   height: 170,
            //   width: 250,
            // ),

            Center(
              child: Text(
                'AutoCRM',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),

            // Container(
            //   alignment: Alignment.center,
            //   child: RichText(
            //       textAlign: TextAlign.center,
            //       text: TextSpan(
            //         text: "AutoCRM System\n",
            //         style: TextStyle(
            //             color: Colors.white.withOpacity(0.6),
            //             fontSize: 25,
            //             fontWeight: FontWeight.bold),
            //       )),
            // )
          ],
        ),
      ),
    ));
  }
}
