import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';


String password;
int _btnCounter = 0;

class PasswordPage extends StatelessWidget {
  final RegisterArguments registerArguments;
  final TextEditingController passwordController = new TextEditingController();
  
  PasswordPage({this.registerArguments});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().black,
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
                  child: MyTextFormField(
                    controller: passwordController,
                    label: MyText().labelPassword,
                    obscureText: true,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                padding: EdgeInsets.only(bottom: 10, top: 10),
                width: 320.0,
                child: Text(MyText().passwordSubtitle,
                    style: TextStyle(color: MyColor().white)),
              ),
              RaisedButton(
                onPressed: () => onPressed(context),
                child: Text(MyText().btnPassword),
              )
            ],
          ),
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      password = passwordController.text;
      MyValidation().passwordValidation(password, context, registerArguments.email,
          registerArguments.phone, registerArguments.username);
      FirebaseCrud().createUser(registerArguments.email, registerArguments.phone,
          registerArguments.username, UniqueKey().toString(), password);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
