import 'dart:async';
import 'package:fillproject/components/myPinCode.dart';
import 'package:fillproject/components/myText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:fillproject/utils/screenUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String verificationCode;
int _btnCounter = 0;

class VerifyPinPage extends StatelessWidget {
  final RegisterArguments arguments;
  bool fieldColor = false;
  bool codeError = false;
  VerifyPinPage({this.arguments});
  String smsCode, wrongCodeError;
  TextEditingController codeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Constant().responsive(context);
    signIn(String smsCode) {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: arguments.verId, smsCode: smsCode);
      FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        Navigator.of(context).pushNamed(Email,
            arguments: RegisterArguments(
                username: arguments.username, phone: arguments.phone));
      }).catchError((e) {
        print('Auth Credential Error : $e');
        wrongCodeError = e.toString();
        print(wrongCodeError);
      });
    }

    onPressed(BuildContext context) {
      smsCode = codeController.text;
     if (smsCode.length < 6) {
       fieldColor = true;
    } else if(wrongCodeError == MyText().wrongCodeError) {
        codeError = true;
    } else {
        if (_btnCounter == 0) {
          FirebaseAuth.instance.currentUser().then((user) {
            if (user != null) {
              Navigator.of(context).pushNamed(Email,
                  arguments: RegisterArguments(
                      username: arguments.username, phone: arguments.phone));
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
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => Center(
            child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 105, bottom: 35),
              child: Text(
                MyText().verifyPageHeadline,
                style: TextStyle(
                  color: MyColor().white,
                  fontSize: ScreenUtil.instance.setSp(23.0),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Text(
                MyText().verifyMoney,
                style: TextStyle(
                    color: MyColor().white,
                    fontSize: ScreenUtil.instance.setSp(40.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 23),
              child: Text(MyText().verifyEnterPin,
                  style: TextStyle(
                      color: MyColor().white,
                      fontSize: ScreenUtil.instance.setSp(17.0),
                      fontWeight: FontWeight.w300)),
            ),
            Container(
              child: Container(
                height: 83,
                width: ScreenUtil.instance.setWidth(350.0),
                child: MyPinCodeTextField(
                  length: 6,
                  animationType: AnimationType.fade,
                  shape: PinCodeFieldShape.circle,
                  animationDuration: Duration(milliseconds: 300),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  textStyle: TextStyle(color: MyColor().white, fontSize: 28),
                  activeColor: fieldColor   ? MyColor().error : MyColor().white,
                  inactiveColor: fieldColor ? MyColor().error : MyColor().white,
                  selectedColor: fieldColor ? MyColor().error : MyColor().white,
                  backgroundColor: MyColor().black,
                  borderWidth: 1.0,
                  controller: codeController,
                  onChanged: (value) {},
                ),
              ),
            ),
            Container(
              child: fieldColor
                  ? Text(
                      MyText().smsLengthSnack,
                      style: TextStyle(color: MyColor().error),
                    )
                  : codeError ? Text(MyText().wrongCode, style: TextStyle(color: MyColor().error) ) : 
                  Text(''),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              width: ScreenUtil.instance.setWidth(316.0),
              height: ScreenUtil.instance.setHeight(67.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(33.5),
                ),
                onPressed: () => onPressed(context),
                child: Text(MyText().btnVerify, style: TextStyle(fontSize: 18)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0),
                child: RichText(
                    text: new TextSpan(children: [
                  new TextSpan(
                      text: MyText().verifyRecieve,
                      style: TextStyle(
                          color: MyColor().white,
                          fontSize: ScreenUtil.instance.setSp(15.0),
                          fontWeight: FontWeight.w300),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed(Register);
                        })
                ]))),
          ],
        )),
      ),
    );
  }
}
