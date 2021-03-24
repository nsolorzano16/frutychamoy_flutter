import 'package:flutter/material.dart';

Widget snackBarMessage(String text, Color bgColor, Color textColor) {
  return SnackBar(
    content: Text(
      text,
      style: TextStyle(fontSize: 16, color: textColor),
    ),
    backgroundColor: bgColor,
  );
}
