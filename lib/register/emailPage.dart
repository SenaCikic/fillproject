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
              Padding(
                padding: const EdgeInsets.only(top: 28, bottom: 35),
                child: Text(MyText().emailHeadline,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      color: MyColor().white,
                    )),
              ),
              Text(MyText().fiveSar,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: MyColor().white,
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 19, top: 28),
                  width: 316.0,
                  height: 83,
                  child: MyTextFormField(
                    controller: emailController,
                    label: MyText().labelEmail,
                    obscureText: false,
                  ),
              ),
              Container(
                width: 316.0,
                height: 67,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(33.5),
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
