import 'package:fillproject/reusable/colors.dart';
import 'package:fillproject/reusable/localStorage.dart';
import 'package:fillproject/reusable/text.dart';
import 'package:fillproject/routes/arguments.dart';
import 'package:fillproject/routes/route_constants.dart';
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
      backgroundColor: ColorsStyle().black,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 180.0),
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                Texts().headline,
                style: TextStyle(fontSize: 60, color: ColorsStyle().white),
              )),
              Center(
                  child: Text(
                Texts().subtitle,
                style: TextStyle(fontSize: 20, color: ColorsStyle().white),
              )),
              Container(
                width: 255.0,
                margin: EdgeInsets.only(top: 130.0),
                child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Register);
                    },
                    child: Text(Texts().btnSU)),
              ),
              Container(
                width: 255.0,
                child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Login);
                    },
                    child: Text(Texts().btnSI)),
              ),
              Container(
                  width: 255.0,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Center(
                      child: FlatButton(
                          onPressed: () => Navigator.of(context).pushNamed(
                              Homepage,
                              arguments: PasswordArguments(
                                  email: '',
                                  password: '',
                                  phoneNo: '',
                                  username: '')),
                          child: Text(
                            Texts().skipThisStep,
                            style: TextStyle(
                                color: ColorsStyle().white, fontSize: 18.0),
                          )))),
            ],
          ),
        ),
      ),
    );
  }
}
