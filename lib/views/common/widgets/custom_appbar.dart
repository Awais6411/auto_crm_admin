import 'package:flutter/material.dart';

AppBar customAppBar(
    {required Function() onTap,
    required String title,
    void Function()? onPressed,
    bool showActions = false}) {
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 8, 99, 155),
    actions: showActions
        ? <Widget>[
            IconButton(
                padding: const EdgeInsets.only(right: 15),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: onPressed),
          ]
        : null,
    leading: InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 18, 131, 223),
            // color: Color.fromARGB(255, 231, 10, 36),
            borderRadius: BorderRadius.circular(30)),
        child: Image.asset(
          "assets/icons/arrow_back.png",
          height: 20,
          width: 20,
          fit: BoxFit.cover,
          color: Colors.white,
        ),
      ),
    ),
    title: Text(title),
    centerTitle: true,
  );
}
