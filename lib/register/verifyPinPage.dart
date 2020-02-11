import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

String verificationCode;
int _btnCounter = 0;

class VerifyPinPage extends StatelessWidget {
  final RegisterArguments arguments;
  VerifyPinPage({this.arguments});

  String code;
  TextEditingController codeC = new TextEditingController();

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
                  controller: codeC,
                  label: MyText().verifyCode,
                  obscureText: false,
                  maxTextLength: 6,
                ),
              ),
            ),
            Container(
              width: 255.0,
              margin: EdgeInsets.only(top: 70.0),
              child: RaisedButton(
                  onPressed: () => onPressed(context), child: Text(MyText().btnVerify)),
            ),
          ],
        )),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      code = codeC.text;
      MyValidation().smsCodeValidation(code, context, arguments.email,
          arguments.phone, arguments.username);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
