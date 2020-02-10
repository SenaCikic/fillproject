import 'dart:async';

import 'package:fillproject/reusable/colors.dart';
import 'package:fillproject/reusable/firebaseMethods/firebaseCrud.dart';
import 'package:fillproject/reusable/text.dart';
import 'package:fillproject/reusable/textFormField.dart';
import 'package:fillproject/reusable/validation.dart';
import 'package:fillproject/routes/arguments.dart';
import 'package:flutter/material.dart';

class SetPassword extends StatelessWidget {
  final RegisterArguments arguments;
  SetPassword({this.arguments});
  String password;
  TextEditingController passwordC = new TextEditingController();
  int _btnCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyle().black,
      body: Builder(
        builder: (context) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 250.0,
                  margin: EdgeInsets.only(top: 50.0),
                  child: TextFormF(
                    controller: passwordC,
                    label: Texts().labelPassword,
                    obscureText: true,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                padding: EdgeInsets.only(bottom: 10, top: 10),
                width: 320.0,
                child: Text(Texts().passwordSubtitle,
                    style: TextStyle(color: ColorsStyle().white)),
              ),
              RaisedButton(
                onPressed: () => onPressed(context),
                child: Text(Texts().btnPassword),
              )
            ],
          ),
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      password = passwordC.text;
      ValidateFields().passwordVal(password, context, arguments.email,
          arguments.phoneNo, arguments.username);
      FirebaseCrud().createUsers(arguments.email, arguments.phoneNo,
          arguments.username, UniqueKey().toString(), password);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
