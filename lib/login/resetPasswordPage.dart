import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(ResetPasswordPage());

int _btnCounter = 0;
String oldPassword, newPassword, repeatPassword;

class ResetPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        width: ScreenUtil.instance.setWidth(316.0),
                        height: ScreenUtil.instance.setHeight(67.0),
                        child: TextFormField(
                            controller: oldPasswordController,
                            decoration: InputDecoration(
                              labelText: MyText().labelOldPassword,
                            ),
                            obscureText: false),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        width: ScreenUtil.instance.setWidth(316.0),
                        height: ScreenUtil.instance.setHeight(67.0),
                        child: TextFormField(
                          style: TextStyle(color: MyColor().white),
                          controller: newPasswordController,
                          decoration: InputDecoration(
                            hasFloatingPlaceholder: false,
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 35.0),
                            labelText: MyText().labelNewPassword,
                            labelStyle: TextStyle(color: MyColor().white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(33.5)),
                              borderSide: BorderSide(color: MyColor().white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(33.5)),
                              borderSide: BorderSide(color: MyColor().white),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(33.5)),
                              borderSide: BorderSide(
                                color: MyColor().error,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(33.5)),
                              borderSide: BorderSide(
                                color: MyColor().error,
                              ),
                            ),
                          ),
                          obscureText: true,
                          validator: (password) =>
                              MyValidation().validatePassword(password),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        width: ScreenUtil.instance.setWidth(316.0),
                        height: ScreenUtil.instance.setHeight(67.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: repeatPasswordController,
                          decoration: InputDecoration(
                            hasFloatingPlaceholder: false,
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 35.0),
                            labelText: MyText().repeatNewPassword,
                            labelStyle: TextStyle(color: MyColor().white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(33.5)),
                              borderSide: BorderSide(color: MyColor().white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(33.5)),
                              borderSide: BorderSide(color: MyColor().white),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(33.5)),
                              borderSide: BorderSide(
                                color: MyColor().error,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(33.5)),
                              borderSide: BorderSide(
                                color: MyColor().error,
                              ),
                            ),
                          ),
                          obscureText: true,
                          validator: (password) => MyValidation()
                              .repeatPasswordValidation(
                                  password, repeatPasswordController.text),
                        ),
                      ),
                    ],
                  )),
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
    newPassword = newPasswordController.text;
    repeatPassword = repeatPasswordController.text;
    oldPassword = oldPasswordController.text;
    final _formState = _formKey.currentState;

    if (_formState.validate()) {
     // if (_btnCounter == 0) {
        print('BRAVOOOOOOOO');
        _btnCounter = 1;
        // Timer(Duration(seconds: 2), () {
        //   _btnCounter = 0;
        // });
    //  } 
    }
  }
}
