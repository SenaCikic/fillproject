import 'package:fillproject/components/myColor.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText; // to see what user is typing 
  final int maxTextLength; // max charachters in field 
  MyTextFormField({
    this.controller,
    this.label,
    this.obscureText,
    this.maxTextLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 40.0),
        labelText: label,
        labelStyle: TextStyle(color: MyColor().white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(33.5)),
          borderSide: BorderSide(color: MyColor().white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(33.5)),
          borderSide: BorderSide(color: MyColor().white),
        ),
      ),
      style: TextStyle(color: MyColor().white),
      obscureText: obscureText,
      maxLength: maxTextLength,
    );
  }
}
