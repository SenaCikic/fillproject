import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoggedIn = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    LoginStorage().autoLogIn(context, name, isLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().black,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 180.0),
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(
                  MyText().headline,
                  style: TextStyle(fontSize: 60, color: MyColor().white),
                )),
                Center(
                    child: Text(
                  MyText().subtitle,
                  style: TextStyle(fontSize: 20, color: MyColor().white),
                )),
                Container(
                  width: 255.0,
                  margin: EdgeInsets.only(top: 130.0),
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Register);
                      },
                      child: Text(MyText().btnSU)),
                ),
                Container(
                  width: 255.0,
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Login);
                      },
                      child: Text(MyText().btnSI)),
                ),
                Container(
                    width: 255.0,
                    margin: EdgeInsets.only(top: 10.0),
                    child: Center(
                        child: FlatButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                                Dashboard,
                                arguments: PasswordArguments(
                                    email: '',
                                    password: '',
                                    phone: '',
                                    username: '')),
                            child: Text(
                              MyText().skipThisStep,
                              style: TextStyle(
                                  color: MyColor().white, fontSize: 18.0),
                            )))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
