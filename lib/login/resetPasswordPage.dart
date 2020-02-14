import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

int _btnCounter = 0;
String oldPassword, newPassword, repeatPassword;

class ResetPasswordPage extends StatelessWidget {

  final TextEditingController oldPasswordController =
      new TextEditingController();
  final TextEditingController newPasswordController =
      new TextEditingController();
  final TextEditingController repeatPasswordController =
      new TextEditingController();


  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    repeatPasswordController.dispose();
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 105, bottom: 35),
                    child: Text(
                      MyText().resetHeadline,
                      style: TextStyle(
                        fontSize: 22,
                        color: MyColor().white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: ScreenUtil.instance.setWidth(316.0),
                height: ScreenUtil.instance.setHeight(67.0),
                child: MyTextFormField(
                    controller: oldPasswordController,
                    label: MyText().labelOldPassword,
                    obscureText: false),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: ScreenUtil.instance.setWidth(316.0),
                height: ScreenUtil.instance.setHeight(67.0),
                child: MyTextFormField(
                    controller: newPasswordController,
                    label: MyText().labelNewPassword,
                    obscureText: true),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: ScreenUtil.instance.setWidth(316.0),
                height: ScreenUtil.instance.setHeight(67.0),
                child: MyTextFormField(
                    controller: repeatPasswordController,
                    label: MyText().repeatNewPassword,
                    obscureText: true),
              ),
              Column(
                children: <Widget>[], //<Widget>
              ), //Column
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: ScreenUtil.instance.setWidth(316.0),
                height: ScreenUtil.instance.setHeight(67.0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(33.5),
                    ),
                    onPressed: () => onPressed(context),
                    child: Text(MyText().btnReset)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
       newPassword = newPasswordController.text;
       repeatPassword = repeatPasswordController.text;
       oldPassword = oldPasswordController.text;
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
