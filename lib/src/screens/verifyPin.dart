import 'dart:async';

import 'package:fillproject/reusable/colors.dart';
import 'package:fillproject/reusable/text.dart';
import 'package:fillproject/reusable/textFormField.dart';
import 'package:fillproject/reusable/validation.dart';
import 'package:fillproject/routes/arguments.dart';
import 'package:flutter/material.dart';

String verificationCode;
int _btnCounter = 0;

class VerifyPin extends StatelessWidget {
  final RegisterArguments arguments;
  VerifyPin({this.arguments});

  String code;
  TextEditingController codeC = new TextEditingController();

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
                  controller: codeC,
                  label: Texts().verifyCode,
                  obscureText: false,
                  maxLength: 6,
                ),
              ),
            ),
            Container(
              width: 255.0,
              margin: EdgeInsets.only(top: 70.0),
              child: RaisedButton(
                  onPressed: () => onPressed(context), child: Text(Texts().btnVerify)),
            ),
          ],
        )),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      code = codeC.text;
      ValidateFields().smsCodeVal(code, context, arguments.email,
          arguments.phoneNo, arguments.username);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
