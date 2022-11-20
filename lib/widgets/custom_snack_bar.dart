import 'package:flutter/material.dart';

SnackBar customSnackBar(BuildContext context, String message, bool error) {
  return SnackBar(
    backgroundColor: error ? Colors.red : Colors.green,
    content: Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontStyle: FontStyle.normal,
      ),
      textAlign: TextAlign.center,
    ),
    duration: Duration(milliseconds: 500),
  );
}
