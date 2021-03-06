/// Password class
///
/// This class contains methods and layout for dashboard page.
///
/// Imports:
///   MyColor constant class with all colors
///   ScreenUtil class for respnsive desing
///   Routes
///   Database methods class
///
/// Authors: Sena Cikic, Danis Preldzic, Adi Cengic, Jusuf Elfarahati
/// Tech387 - T2
/// Feb, 2020

import 'dart:async';
import 'dart:io';
import 'package:fillproject/components/constants/MyText.dart';
import 'package:fillproject/components/constants/myColor.dart';
import 'package:fillproject/components/mySnackbar.dart';
import 'package:fillproject/components/myTextComponent.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:fillproject/utils/screenUtils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

String password, username = "";
int _btnCounter = 0;
bool isLoggedIn = false;

class PasswordPage extends StatefulWidget {
  final RegisterArguments arguments;

  PasswordPage({this.arguments});

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Constant().responsive(context);
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: new AppBar(
        title: new Text(""),
        backgroundColor: MyColor().black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushNamed(Email);
          },
        ),
      ),
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 28 / pixelRatio, bottom: 35 / pixelRatio),
                    child: MyTextComponent(text: MyText().passwordHeadline),
                  ),
                  Text(MyText().fiveSar,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ScreenUtil.instance.setSp(40),
                        color: MyColor().white,
                      )),
                  Container(
                      width: ScreenUtil.instance.setWidth(316.0),
                      height: ScreenUtil.instance.setHeight(92.0),
                      margin: EdgeInsets.only(bottom: 19 / pixelRatio, top: 28 / pixelRatio),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          enableSuggestions: false,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hasFloatingPlaceholder: false,
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0 / pixelRatio, horizontal: 35.0 / pixelRatio),
                            labelText: MyText().labelPassword,
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
                          style: TextStyle(color: MyColor().white),
                          obscureText: true,
                          validator: (password) =>
                              MyValidation().validatePassword(password),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 21 / pixelRatio, left: 43 / pixelRatio, right: 43 / pixelRatio),
                    width: ScreenUtil.instance.setWidth(316.0),
                    child: RichText(
                      text: new TextSpan(children: [
                        new TextSpan(
                          text: MyText().passwordSubtitle1,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil.instance.setSp(12)),
                        ),
                        new TextSpan(
                            text: MyText().privacy,
                            style: new TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil.instance.setSp(12)),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                _save();

                                launch('https://google.com');
                              }),
                        new TextSpan(
                          text: MyText().passwordSubtitle2,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil.instance.setSp(12)),
                        ),
                        new TextSpan(
                            text: MyText().termsOfService,
                            style: new TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil.instance.setSp(12)),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                _save();

                                launch('https://google.com');
                              })
                      ]),
                    ),
                  ),
                  Container(
                      width: ScreenUtil.instance.setWidth(316.0),
                      height: ScreenUtil.instance.setHeight(67.0),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(33.5),
                          ),
                          onPressed: () async {
                            try {
                              final result =
                                  await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                onPressed(context);
                                _save();
                              }
                            } on SocketException catch (_) {
                              MySnackbar().showSnackbar(
                                  MyText().checkConnection,
                                  context,
                                  MyText().snackUndo);
                            }
                          },
                          child: Text(MyText().btnPassword,
                              style: TextStyle(
                                  fontSize: ScreenUtil.instance.setSp(18))))),
                ],
              ),
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
        loginUser(widget.arguments.username, isLoggedIn);
        FirebaseCrud().createUser(widget.arguments.email,
            widget.arguments.phone, widget.arguments.username, password, 5);
        Navigator.of(context).pushNamed(NavBar,
            arguments: PasswordArguments(
                email: widget.arguments.email,
                phone: widget.arguments.phone,
                username: widget.arguments.username,
                password: password));
        _btnCounter = 1;
        Timer(Duration(seconds: 2), () {
          _btnCounter = 0;
        });
      }
    }
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_password';
    final value = password;
    prefs.setString(key, value);
    print('saved $value');
  }

  Future<Null> loginUser(String username, bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    // name = usernameController.text;
    setState(() {
      username = username;
      isLoggedIn = true;
    });
  }
}
