import 'dart:async';
import 'package:fillproject/components/myPinCode.dart';
import 'package:fillproject/components/myText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

String verificationCode;
int _btnCounter = 0;

class VerifyPinPage extends StatelessWidget {
  final RegisterArguments arguments;
  VerifyPinPage({this.arguments});
  String smsCode;
  TextEditingController codeController = new TextEditingController();


  @override
  Widget build(BuildContext context) {


    signIn(String smsCode) {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: arguments.verId, smsCode: smsCode);
      FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        Navigator.of(context).pushNamed(Email,
            arguments: RegisterArguments(
                username: arguments.username, phone: arguments.phone));
      }).catchError((e) {
        print('Auth Credential Error : $e');
      });
    }

    onPressed(BuildContext context) {
      if (_btnCounter == 0) {
        FirebaseAuth.instance.currentUser().then((user) {
          if (user != null) {
            Navigator.of(context).pushNamed(Email,
                arguments: RegisterArguments(
                    username: arguments.username, phone: arguments.phone ));
          } else {
            signIn(codeController.text);
          }
        });
        _btnCounter = 1;
        Timer(Duration(seconds: 2), () {
          _btnCounter = 0;
        });
      }
    }

    return Scaffold(
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => Center(
            child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 60),
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
              margin: EdgeInsets.only(top: 60),
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
              margin: EdgeInsets.only(top: 40),
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
                child: MyPinCodeTextField(
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
                  controller: codeController,
                  onChanged: (value) {},
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
                child: Text(MyText().btnVerify, style: TextStyle(fontSize: 20)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: RichText(
                  text: new TextSpan(children: [new TextSpan(
                        text: MyText().verifyRecieve,
                        style: TextStyle(
                      color: MyColor().white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(Register);
                          })]))
            ),
          ],
        )),
      ),
    );
  }
}
