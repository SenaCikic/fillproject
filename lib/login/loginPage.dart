import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                 width: ScreenUtil.instance.setWidth(316.0),
                height: ScreenUtil.instance.setHeight(92.0),
                margin: EdgeInsets.only(top: 10.0, left: 54.0, right: 55.0),
                child: MyTextFormField(
                    controller: usernameController,
                    label: MyText().labelUsername,
                    obscureText: false),
              ),
              Container(
                 width: ScreenUtil.instance.setWidth(316.0),
                height: ScreenUtil.instance.setHeight(92.0),
                margin: EdgeInsets.only(top: 10.0, left: 54.0, right: 55.0),

                child: MyTextFormField(
                    controller: passwordController,
                    label: MyText().labelPassword,
                    obscureText: true),
              ),

              Container(
              width: ScreenUtil.instance.setWidth(316.0),
              height: ScreenUtil.instance.setHeight(67.0),
              margin: EdgeInsets.only(left: 54.0, right: 55.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(33.5),
                ),
                onPressed: () => onPressed(context),
                child: Text(MyText().btnEmail, style: TextStyle(fontSize: 18)),
              )),
               Container(
                margin: EdgeInsets.only(top: 20.0),
                child: RichText(
                    text: new TextSpan(children: [
                  new TextSpan(
                      text: MyText().resetPass,
                      style: TextStyle(
                          color: MyColor().white,
                          fontSize: ScreenUtil.instance.setSp(15.0),
                          fontWeight: FontWeight.w300),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed(EmailReset);
                        })
                ]))),
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
