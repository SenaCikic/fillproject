import 'package:fillproject/components/constants/myColor.dart';
import 'package:flutter/material.dart';

class MySnackbar {

  void showSnackbar(String snackText, BuildContext context, String snackAction) {
      Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromRGBO(225, 225, 225, 1.0),
      content: Text(snackText, style: TextStyle(color: MyColor().black),),
      action: SnackBarAction(
        label: snackAction,
        onPressed: () {},
      ),
    ));
  }
}
