import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

String password;
int _btnCounter = 0;

class PasswordPage extends StatelessWidget {
  final RegisterArguments arguments;
  final TextEditingController passwordController = new TextEditingController();

  PasswordPage({this.arguments});

  void dispose() {
    passwordController.dispose();
    dispose();
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
              Text(MyText().passwordHeadline,
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
                    controller: passwordController,
                    label: MyText().labelPassword,
                    obscureText: true,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25, top: 10),
                width: 320.0,
                child: RichText(
                  text: new TextSpan(children: [
                    new TextSpan(
                      text: MyText().passwordSubtitle1,
                      style: new TextStyle(color: Colors.white),
                    ),
                    new TextSpan(
                        text: MyText().privacy,
                        style: new TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            // launch('https://google.com');
                          }),
                    new TextSpan(
                      text: MyText().passwordSubtitle2,
                      style: new TextStyle(color: Colors.white),
                    ),
                    new TextSpan(
                        text: MyText().termsOfService,
                        style: new TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            // launch('https://google.com');
                          })
                  ]),
                ),
              ),
              Container(
                width: 320.0,
                height: 60,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      onPressed(context);
                    },
                    child: Text(MyText().btnPassword)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      password = passwordController.text;
      MyValidation().passwordValidation(
          password,
          context,
          arguments.email,
          arguments.phone,
          arguments.username);
      FirebaseCrud().createUser(
          arguments.email,
          arguments.phone,
          arguments.username,
          UniqueKey().toString(),
          password);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
