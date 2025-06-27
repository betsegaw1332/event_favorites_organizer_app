import 'package:flutter/material.dart';

abstract class AppHelperFunctions {
  static void showAppSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
