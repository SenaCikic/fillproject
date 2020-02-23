import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
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

String password;
int _btnCounter = 0;

class PasswordPage extends StatelessWidget {
  final RegisterArguments arguments;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = new TextEditingController();

  PasswordPage({this.arguments});

  @override
  Widget build(BuildContext context) {
    Constant().responsive(context);
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
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 28, bottom: 35),
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
                      margin: EdgeInsets.only(bottom: 19, top: 28),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hasFloatingPlaceholder: false,
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 35.0),
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
                    margin: EdgeInsets.only(bottom: 21, left: 43, right: 43),
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
                                // launch('https://google.com');
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
                                // launch('https://google.com');
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
                          onPressed: () {
                            onPressed(context);
                                _save();
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
        FirebaseCrud().createUser(arguments.email, arguments.phone,
            arguments.username, password, 5);
        Navigator.of(context).pushNamed(NavBar,
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

      _save() async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'user_password';
        final value = password;
        prefs.setString(key, value);
        print('saved $value');
      }
}
