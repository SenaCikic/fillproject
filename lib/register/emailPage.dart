import 'dart:async';

import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

String email;
int _btnCounter = 0;

class EmailPage extends StatelessWidget {
  final RegisterArguments arguments;
  final TextEditingController emailController = new TextEditingController();

  EmailPage({this.arguments});

  void dispose() {
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(""),
        backgroundColor: MyColor().black,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(MyText().emailHeadline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: MyColor().white,
                  )),
              Text(MyText().fiveSar,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: MyColor().white,
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: Container(
                  width: 320.0,
                  height: 60,
                  margin: EdgeInsets.only(top: 20.0),
                  child: MyTextFormField(
                    controller: emailController,
                    label: MyText().labelEmail,
                    obscureText: false,
                  ),
                ),
              ),
              Container(
                width: 320.0,
                height: 60,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () => onPressed(context),
                    child: Text(MyText().btnEmail)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      email = emailController.text;
      MyValidation()
          .emailValidation(email, arguments.username, arguments.phone, context);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
