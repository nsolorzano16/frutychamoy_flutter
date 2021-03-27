import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final String labelText;
  final int maxLines;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomTextField({
    Key key,
    @required this.icon,
    @required this.hintText,
    @required this.labelText,
    @required this.controller,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(icon),
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
