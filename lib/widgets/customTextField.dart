import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final String labelText;
  final TextEditingController controller;

  const CustomTextField({
    Key key,
    @required this.icon,
    @required this.hintText,
    @required this.labelText,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: Icon(Icons.mail),
            hintText: hintText,
            labelText: labelText),
      ),
    );
  }
}
