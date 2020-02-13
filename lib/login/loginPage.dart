import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:flutter/material.dart';

int _btnCounter = 0;
String username, password;

class LoginPage extends StatelessWidget {
  final String usernameExists, passwordExists;

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  LoginPage({this.usernameExists, this.passwordExists});

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 260.0),
                  child: Text(
                    MyText().loginHeadline,
                    style: TextStyle(
                      fontSize: 22,
                      color: MyColor().white,
                    ),
                  ),
                ),
              ),
              Container(
                width: 250.0,
                margin: EdgeInsets.only(top: 50.0),
                child: MyTextFormField(
                    controller: usernameController,
                    label: MyText().labelUsername,
                    obscureText: false),
              ),
              Container(
                width: 250.0,
                margin: EdgeInsets.only(top: 10.0),
                child: MyTextFormField(
                    controller: passwordController,
                    label: MyText().labelPassword,
                    obscureText: true),
              ),
              Column(
                children: <Widget>[], //<Widget>
              ), //Column
              Container(
                width: 255.0,
                margin: EdgeInsets.only(top: 70.0),
                child: RaisedButton(
                    onPressed: () => onPressed(context),
                    child: Text(MyText().btnLogin)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      username = usernameController.text;
      password = passwordController.text;

      /// validacija
      // MyValidation().loginValidation(
      //     username, password, usernameExists, passwordExists, context);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
