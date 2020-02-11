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
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 180.0),
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                MyText().headline,
                style: TextStyle(fontSize: 60, color: MyColor().white),
              )),
              Padding(
                  padding: EdgeInsets.only(top: 250),
                  child: Text(
                    MyText().subtitle,
                    style: TextStyle(fontSize: 20, color: MyColor().white),
                  )),
                  Text(MyText().fiveSar, style: TextStyle(fontSize: 20, color: MyColor().white)),
              Container(
                width: 320.0,
                height: 60,
                margin: EdgeInsets.only(top: 30.0, bottom: 15),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Register);
                    },
                    child: Text(MyText().btnSU)),
              ),
              Container(
                width: 320.0,
                height: 60,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Login);
                    },
                    child: Text(MyText().btnSI)),
              ),
              Container(
                  width: 255.0,
                  margin: EdgeInsets.only(top: 20.0),
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
    );
  }
}
