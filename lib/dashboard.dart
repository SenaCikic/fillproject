import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPage extends StatefulWidget {
  final PasswordArguments arguments;

  DashboardPage({this.arguments});

  @override
  _DashboardPageState createState() =>
      _DashboardPageState(arguments: arguments);
}

class _DashboardPageState extends State<DashboardPage> {
  final PasswordArguments arguments;
  bool isLoggedIn = false;
  String name = '';

  _DashboardPageState({this.arguments});
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: MyColor().black,
        appBar: new AppBar(
          title: new Text(MyText().appBarDash),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(MyText().dashHeadline,
                    style: TextStyle(color: MyColor().white)),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                    MyText().dashSub +
                        arguments.email +
                        arguments.username +
                        MyText().dashSub1 +
                        arguments.password,
                    style: TextStyle(color: MyColor().white)),
                SizedBox(
                  height: 15.0,
                ),
                new OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.red, style: BorderStyle.solid, width: 3.0),
                  child: Text(MyText().btnLogout,
                      style: TextStyle(color: MyColor().white)),
                  onPressed: () => onPressed(context),
                ),
              ],
            ),
          ),
        ));
  }

  onPressed(BuildContext context) {
    FirebaseAuth.instance.signOut().then((action) {
      Navigator.of(context).pushNamed(Home);
    }).catchError((e) {
      print(e);
    });
    LoginStorage().logout(name, isLoggedIn);
  }
}
