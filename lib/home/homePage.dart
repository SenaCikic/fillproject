import 'dart:async';
import 'dart:io';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/mySnackbar.dart';
import 'package:fillproject/components/myText.dart';
import 'package:fillproject/firebaseMethods/firebaseSignIn.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:fillproject/utils/screenUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoggedIn = false;
  String name = '', username;

  @override
  void initState() {
    super.initState();

    print(username);

    autoLogIn(context, isLoggedIn);

  }

  @override
  Widget build(BuildContext context) {
    Constant().responsive(context);
    return Scaffold(
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => WillPopScope(
          onWillPop: _onWillPop,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 245.0),
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Text(
                      MyText().headline,
                      style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(70.0),
                          color: MyColor().white,
                          fontFamily: 'RobotoMono'),
                    )),
                    Padding(
                        padding: EdgeInsets.only(top: 120),
                        child: Text(
                          MyText().subtitle,
                          style: TextStyle(
                              fontSize: ScreenUtil.instance.setSp(23.0),
                              color: MyColor().white),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                      width: ScreenUtil.instance.setWidth(316.0),
                      height: ScreenUtil.instance.setHeight(67.0),
                      margin: EdgeInsets.only(
                          top: 27.0, bottom: 15, left: 49, right: 49),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(33.5),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(Register);
                          },
                          child: Text(MyText().btnSU)),
                    ),
                    Container(
                      width: ScreenUtil.instance.setWidth(316.0),
                      height: ScreenUtil.instance.setHeight(67.0),
                      margin: EdgeInsets.only(bottom: 33, left: 49, right: 49),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(33.5),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Login); // go to Login Page
                          },
                          child: Text(MyText().btnSI)),
                    ),
                    Container(
                        width: ScreenUtil.instance.setWidth(255.0),
                        child: Center(
                            child: FlatButton(
                                onPressed: () async {
                                  try {
                                    final result = await InternetAddress.lookup(
                                        'google.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                      username = randomAlphaNumeric(5);
                                      loginUser();
                                      FirebaseSignIn()
                                          .signInAnonymously(username);
                                      Timer(Duration(milliseconds: 500), () {
                                        Navigator.of(context).pushNamed(NavBar,
                                            arguments: PasswordArguments(
                                                email: '',
                                                password: '',
                                                phone: '',
                                                username: username));
                                      });
                                    }
                                  } on SocketException catch (_) {
                                    MySnackbar().showSnackbar(
                                        MyText().checkConnection,
                                        context,
                                        MyText().snackUndo);
                                  }
                                },
                                // FirebaseJson().importJson(),
                                child: Text(
                                  MyText().skipThisStep,
                                  style: TextStyle(
                                      color: MyColor().white, fontSize: 23.0),
                                ))))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(MyText().willQuestion),
            content: new Text(MyText().willQuestion1),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        true;
  }

  void autoLogIn(BuildContext context, bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('username');
    print(username);
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        username = userId;
      });

      Navigator.of(context).pushNamed(NavBar,
          arguments: PasswordArguments(
              email: '', password: '', phone: '', username: username));
      return;
    }
  }

  //duplanje koda i implementacija funckije ovdje zbog setState-a -> NAUCIMO BLoC :)
  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    setState(() {
      username = username;
      isLoggedIn = true;
    });
  }
}
