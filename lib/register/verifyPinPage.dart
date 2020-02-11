import 'dart:async';
import 'package:fillproject/components/myText.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
        builder: (context) => SingleChildScrollView(
          child:
          Center(
              child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 70),
                child: Text(
                  MyText().verifyPageHeadline1,
                  style: TextStyle(
                    color: MyColor().white,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                child: Text(MyText().verifyPageHeadline2,
                    style: TextStyle(color: MyColor().white, fontSize: 20)),
              ),
              Container(
                margin: EdgeInsets.only(top: 70),
                child: Text(MyText().verifyMoney1,
                    style: TextStyle(
                        color: MyColor().white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                child: Text(MyText().verifyMoney2,
                    style: TextStyle(
                        color: MyColor().white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(MyText().verifyEnterPin,
                    style: TextStyle(
                        color: MyColor().white,
                        fontSize: 17,
                        fontWeight: FontWeight.w300)),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Container(
                    width: 310.0,
                    child: PinCodeTextField(
                      length: 6,
                      animationType: AnimationType.fade,
                      shape: PinCodeFieldShape.circle,
                      animationDuration: Duration(milliseconds: 300),
                      fieldHeight: 60,
                      fieldWidth: 50,
                      textStyle: TextStyle(color: MyColor().white, fontSize: 28),
                      activeColor: MyColor().white,
                      inactiveColor: MyColor().white,
                      selectedColor: MyColor().white,
                      backgroundColor: MyColor().black,
                      borderWidth: 1.0,
                      onChanged: (value) {},
                    ),
                    ),
              ),
              Container(
                width: 320.0,
                height: 60,
                margin: EdgeInsets.only(top: 70.0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () => onPressed(context),
                    child: Text(MyText().btnVerify)),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(MyText().verifyRecieve,
                    style: TextStyle(
                        color: MyColor().white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300)),
              ),
            ],
          )),
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      code = codeC.text;
      MyValidation().smsCodeValidation(
          code, context, arguments.email, arguments.phone, arguments.username);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
