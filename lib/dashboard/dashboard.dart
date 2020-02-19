import 'package:fillproject/components/MySAR.dart';
import 'package:fillproject/components/myCardMCQ.dart';
import 'package:fillproject/components/myCashBalance.dart';
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
      body: Center(
          child: Column(children: <Widget>[
        MyCashBalance(text: 'Your cash\tbalance'),
        MySAR(text: ' 5\tSAR'),
        //MyCardYesNo(),
        MyCardMCQ(),
      ])),
    );
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
