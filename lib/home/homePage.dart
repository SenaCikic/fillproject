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
    LoginStorage().autoLogIn(context, name, isLoggedIn); //auto login on app kill and close
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().black,
      body: SingleChildScrollView(
              child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 245.0),
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(
                  MyText().headline,
                  style: TextStyle(fontSize: 70, color: MyColor().white, fontFamily: 'RobotoMono'),
                )),
                Padding(
                    padding: EdgeInsets.only(top: 140 ,bottom: 31),
                    child: Text(
                      MyText().subtitle,
                      style: TextStyle(fontSize: 23, color: MyColor().white),
                      textAlign: TextAlign.center,
                    )),
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
                        Navigator.of(context).pushNamed(Login); // go to Login Page
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
      ),
    );
  }
}
