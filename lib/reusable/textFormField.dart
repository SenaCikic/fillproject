import 'package:flutter/material.dart';

import 'colors.dart';

class TextFormF extends StatelessWidget {
  TextEditingController controller;
  String label;
  bool obscureText;
  int maxLength;
  TextFormF({this.controller, this.label, this.obscureText, this.maxLength, });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: ColorsStyle().white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide(color: ColorsStyle().white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide(color: ColorsStyle().white),
        ),
      ),
      style: TextStyle(color: ColorsStyle().white),
      obscureText: obscureText,
      maxLength: maxLength,
    );
  }
}
