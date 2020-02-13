import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

String password;
int _btnCounter = 0;

class PasswordPage extends StatelessWidget {
  final RegisterArguments arguments;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                    fontSize: 23,
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
                  height: 100,
                  margin: EdgeInsets.only(top: 28.0, , bottom: 35),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        
                        contentPadding: const EdgeInsets.all(20.0),
                        labelText: MyText().labelPassword,
                        labelStyle: TextStyle(color: MyColor().white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: MyColor().white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: MyColor().white),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(
                            color: MyColor().error,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(
                            color: MyColor().error,
                          ),
                        ),
                      ),
                      style: TextStyle(color: MyColor().white),
                      obscureText: false,
                      validator: (password) => MyValidation().validatePassword(password),
                    ),
                  ),
                ),
                Text(MyText().fiveSar,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: MyColor().white,
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 19, top: 28),
                  child: Container(
                    width: 316.0,
                    height: 83,
                    margin: EdgeInsets.only(top: 19.0),
                    child: MyTextFormField(
                      controller: passwordController,
                      label: MyText().labelPassword,
                      obscureText: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 21, left: 43, right: 43),
                  width: 316.0,
                  child: RichText(
                    text: new TextSpan(children: [
                      new TextSpan(
                        text: MyText().passwordSubtitle1,
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      new TextSpan(
                          text: MyText().privacy,
                          style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              // launch('https://google.com');
                            }),
                      new TextSpan(
                        text: MyText().passwordSubtitle2,
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      new TextSpan(
                          text: MyText().termsOfService,
                          style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              // launch('https://google.com');
                            })
                    ]),
                  ),
                ),
                Container(
                  width: 316.0,
                  height: 67,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(33.5),
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
      ),
    );
  }

 

  onPressed(BuildContext context) {
    password = passwordController.text;
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      if (_btnCounter == 0) {
        FirebaseCrud().createUser(arguments.email, arguments.phone,
            arguments.username, UniqueKey().toString(), password);
        Navigator.of(context).pushNamed(Dashboard,
            arguments: PasswordArguments(
                email: arguments.email,
                phone: arguments.phone,
                username: arguments.username,
                password: password));
        _btnCounter = 1;
        Timer(Duration(seconds: 2), () {
          _btnCounter = 0;
        });
      }

    }
  }
}
