import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/emptyCont.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/firebaseMethods/firebaseCheck.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _btnCounter = 0;
  String username, password;
  bool usernamePostoji = false;
  bool passwordPostoji = false;
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
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(right: 99.5, left: 99.6, bottom: 70.5),
                  child: SizedBox(
                      width: 215,
                      height: 60,
                      child: Text(MyText().loginHeadline,
                          style: const TextStyle(
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              fontFamily: "LoewNextArabic",
                              fontStyle: FontStyle.normal,
                              fontSize: 23.0),
                          textAlign: TextAlign.center)),
                ),
                Container(
                  width: ScreenUtil.instance.setWidth(316.0),
                  height: ScreenUtil.instance.setHeight(92.0),
                  margin: EdgeInsets.only(top: 10.0, left: 54.0, right: 55.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: usernameController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorStyle: TextStyle(
                          inherit: true,
                          textBaseline: TextBaseline.ideographic),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 35.0),
                      labelText: MyText().labelUsername,
                      labelStyle: TextStyle(
                        color: MyColor().white,
                        fontSize: 18,
                        fontFamily: "LoewNextArabic",
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(color: MyColor().white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(color: MyColor().white),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(
                          color: MyColor().error,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
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
                  margin: EdgeInsets.only(top: 10.0, left: 54.0, right: 55.0),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 35.0),
                      labelText: MyText().labelPassword,
                      labelStyle: TextStyle(
                          color: MyColor().white,
                          fontFamily: "LoewNextArabic",
                          fontSize: 18.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(color: MyColor().white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(color: MyColor().white),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(
                          color: MyColor().error,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
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
                    margin: EdgeInsets.only(left: 54.0, right: 55.0, top: 10.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(33.5),
                      ),
                      onPressed: () => onPressed(context),
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
                      future: FirebaseCheck().doesNameAlreadyExist(username),
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
                      future: FirebaseCheck().doesPassAlreadyExist(password),
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
    );
  }

  onPressed(BuildContext context) {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      if (_btnCounter == 0) {
        username = usernameController.text;
        password = passwordController.text;
        Navigator.of(context).pushNamed(Dashboard,
            arguments: PasswordArguments(
                username: username, password: password, email: '', phone: ''));
        _btnCounter = 1;
        Timer(Duration(seconds: 2), () {
          _btnCounter = 0;
        });
      }
    }
  }
}
