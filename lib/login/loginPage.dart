/// Login Page class
///
/// This class contains methods and layout for login page.
///
/// Imports:
///   MyColor constant class with all colors
///   Cloud_firestore for connection to the firebase
///   ScreenUtil class for respnsive desing
///   Routes
///   Database connections
///
/// Authors: Sena Cikic, Danis Preldzic, Adi Cengic, Jusuf Elfarahati
/// Tech387 - T2
/// Feb, 2020

import 'dart:async';
import 'dart:io';
import 'package:fillproject/components/constants/MyText.dart';
import 'package:fillproject/components/constants/fontsConstants.dart';
import 'package:fillproject/components/constants/myColor.dart';
import 'package:fillproject/components/emptyCont.dart';
import 'package:fillproject/components/mySnackbar.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/firebaseMethods/firebaseCheck.dart';
import 'package:fillproject/home/homePage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _btnCounter = 0;
  String username, password;
  bool usernamePostoji = false;
  bool passwordPostoji = false;
  bool isLoggedIn = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(""),
        backgroundColor: MyColor().black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SignUp()));
          },
        ),
      ),
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 59, left: 49, right: 49, top: 28),
                      child: SizedBox(
                          width: 215,
                          height: 60,
                          child: Text(MyText().loginHeadline,
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'LoewNextArabic',
                                  fontSize: 23.0),
                              textAlign: TextAlign.center)),
                    ),
                    Container(
                      width: ScreenUtil.instance.setWidth(316.0),
                      height: ScreenUtil.instance.setHeight(92.0),
                      margin:
                          EdgeInsets.only(top: 10.0, left: 54.0, right: 55.0),
                      child: TextFormField(
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.sentences,
                        controller: usernameController,
                        decoration: InputDecoration(
                          // floatingLabelBehavior: FloatingLabelBehavior.never,
                          hasFloatingPlaceholder: false,
                          errorStyle: TextStyle(
                              inherit: true,
                              textBaseline: TextBaseline.ideographic),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 35.0),
                          labelText: MyText().labelUsername,
                          labelStyle: TextStyle(
                            color: MyColor().white,
                            fontSize: 18,
                            fontFamily: arabic,
                          ),
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
                        validator: (username) => MyValidation()
                            .validateUsernameLogin(username, usernamePostoji),
                        onChanged: (input) {
                          setState(() {
                            username = input;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: ScreenUtil.instance.setWidth(316.0),
                      height: ScreenUtil.instance.setHeight(92.0),
                      margin:
                          EdgeInsets.only(top: 10.0, left: 54.0, right: 55.0),
                      child: TextFormField(
                        enableSuggestions: false,
                        controller: passwordController,
                        decoration: InputDecoration(
                          // floatingLabelBehavior: FloatingLabelBehavior.never,
                          hasFloatingPlaceholder: false,
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 35.0),
                          labelText: MyText().labelPassword,
                          labelStyle: TextStyle(
                              color: MyColor().white,
                              fontFamily: arabic,
                              fontSize: 18.0),
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
                        validator: (password) => MyValidation()
                            .validatePasswordLogin(password, passwordPostoji),
                        onChanged: (input) {
                          setState(() {
                            password = input;
                          });
                        },
                      ),
                    ),
                    Container(
                        width: ScreenUtil.instance.setWidth(316.0),
                        height: ScreenUtil.instance.setHeight(67.0),
                        margin:
                            EdgeInsets.only(left: 54.0, right: 55.0, top: 10.0),
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
                              }
                            } on SocketException catch (_) {
                              MySnackbar().showSnackbar(
                                  MyText().checkConnection,
                                  context,
                                  MyText().snackUndo);
                            }
                          },
                          child: Text(MyText().btnLogin,
                              style: TextStyle(fontSize: 18)),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: RichText(
                            text: new TextSpan(children: [
                          new TextSpan(
                              text: MyText().resetPass,
                              style: TextStyle(
                                  color: MyColor().white,
                                  fontSize: ScreenUtil.instance.setSp(18.0),
                                  fontWeight: FontWeight.w300),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushNamed(EmailReset);
                                })
                        ]))),
                    Column(
                      children: <Widget>[
                        FutureBuilder(
                          future:
                              FirebaseCheck().doesNameAlreadyExist(username),
                          builder: (context, AsyncSnapshot<bool> result) {
                            if (!result.hasData) {
                              return EmptyContainer();
                            }
                            if (result.data) {
                              usernamePostoji = false;
                              return EmptyContainer();
                            } else {
                              usernamePostoji = true;
                              return EmptyContainer();
                            }
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        FutureBuilder(
                          future: FirebaseCheck()
                              .doesPassAlreadyExist(password, username),
                          builder: (context, AsyncSnapshot<bool> result) {
                            if (!result.hasData) {
                              return EmptyContainer();
                            }
                            if (result.data) {
                              passwordPostoji = false;
                              return EmptyContainer();
                            } else {
                              passwordPostoji = true;
                              return EmptyContainer();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      if (_btnCounter == 0) {
        username = usernameController.text;
        password = passwordController.text;
        loginUser();
        Navigator.of(context).pushNamed(NavBar,
            arguments: PasswordArguments(
                username: username, password: password, email: '', phone: ''));
        _btnCounter = 1;
        Timer(Duration(seconds: 2), () {
          _btnCounter = 0;
        });
      }
    }
  }

  //duplanje koda i implementacija funckije ovdje zbog setState-a
  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    // name = usernameController.text;
    setState(() {
      username = usernameController.text;
      isLoggedIn = true;
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignUp()));
    return EmptyContainer() ?? true;
  }
}
