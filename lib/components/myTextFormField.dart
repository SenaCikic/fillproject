import 'package:fillproject/components/myColor.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final int maxTextLength;
  MyTextFormField({
    this.controller,
    this.label,
    this.obscureText,
    this.maxTextLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20.0),
        labelText: label,
        labelStyle: TextStyle(color: MyColor().white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: MyColor().white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: MyColor().white),
        ),
      ),
      style: TextStyle(color: MyColor().white),
      obscureText: obscureText,
      maxLength: maxTextLength,
    );
  }
}
