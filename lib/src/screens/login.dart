import 'dart:async';

import 'package:fillproject/reusable/colors.dart';
import 'package:fillproject/reusable/text.dart';
import 'package:fillproject/reusable/textFormField.dart';
import 'package:fillproject/reusable/validation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  String username, password, usernameExists, passExists;
  int _btnCounter = 0;

  TextEditingController usernameC = new TextEditingController();
  TextEditingController passwordC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyle().black,
      body: Builder(
        builder: (context) => ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 260.0),
                    child: Text(
                      Texts().loginHeadline,
                      style: TextStyle(
                        fontSize: 22,
                        color: ColorsStyle().white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 250.0,
                  margin: EdgeInsets.only(top: 50.0),
                  child: TextFormF(
                      controller: usernameC,
                      label: Texts().labelUsername,
                      obscureText: false),
                ),
                Container(
                  width: 250.0,
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextFormF(
                      controller: passwordC,
                      label: Texts().labelPassword,
                      obscureText: true),
                ),
                Column(
                  children: <Widget>[], //<Widget>
                ), //Column
                Container(
                  width: 255.0,
                  margin: EdgeInsets.only(top: 70.0),
                  child: RaisedButton(
                      onPressed: () => onPressed(context), child: Text(Texts().btnLogin)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      username = usernameC.text;
      password = passwordC.text;
      /// validacija
      ValidateFields()
          .loginVal(username, password, usernameExists, passExists, context);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
