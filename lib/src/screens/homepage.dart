import 'package:fillproject/reusable/colors.dart';
import 'package:fillproject/reusable/localStorage.dart';
import 'package:fillproject/reusable/text.dart';
import 'package:fillproject/routes/arguments.dart';
import 'package:fillproject/routes/route_constants.dart';
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

  //String uid = '';

  //getUid() {}

  @override
  void initState() {
    //this.uid = '';
    // FirebaseAuth.instance.currentUser().then((val) {
    //   setState(() {
    //     this.uid = val.uid;
    //   });
    // }).catchError((e) {
    //   print(e);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: ColorsStyle().black,
        appBar: new AppBar(
          title: new Text(Texts().appBarDash),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(Texts().dashHeadline,
                    style: TextStyle(color: ColorsStyle().white)),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                    Texts().dashSub +
                        arguments.email +
                        arguments.username +
                        Texts().dashSub1 +
                        arguments.password,
                    style: TextStyle(color: ColorsStyle().white)),
                SizedBox(
                  height: 15.0,
                ),
                new OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.red, style: BorderStyle.solid, width: 3.0),
                  child: Text(Texts().btnLogout,
                      style: TextStyle(color: ColorsStyle().white)),
                  onPressed: () => onPressed(context),
                ),
              ],
            ),
          ),
        ));
  }

  onPressed(BuildContext context) {
    FirebaseAuth.instance.signOut().then((action) {
      Navigator.of(context).pushNamed(LoginAndSignUp);
    }).catchError((e) {
      print(e);
    });
    LoginStorage().logout(name, isLoggedIn);
  }
}
