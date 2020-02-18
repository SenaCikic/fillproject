import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(DashboardPage());

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
            child: ListView(children: <Widget>[
      // 5 SAR
      Container(
          margin: EdgeInsets.only(top: 94.0, bottom: 41.0),
          width: 120,
          child: Text('Your cash\tbalance',
              style: const TextStyle(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Helvetica",
                  fontStyle: FontStyle.normal,
                  fontSize: 23.0),
              textAlign: TextAlign.center)),
      // 5 SAR
      Container(
          margin: EdgeInsets.only(bottom: 41.0),
          width: 92,
          child: Text(" 5\tSAR",
              style: const TextStyle(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                  fontFamily: "LoewNextArabic",
                  fontStyle: FontStyle.normal,
                  fontSize: 40.0),
              textAlign: TextAlign.center)),
      // Rectangle
      Container(
          width: 336,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: const Color(0xff000000)),
          child: Stack(children: [
            // This part is for que Copy
            PositionedDirectional(
              top: 98,
              start: 49,
              child: SizedBox(
                  width: 245,
                  height: 84,
                  child: Text(
                      "This part is for questionsThis part is for questionsThis ?",
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          fontFamily: "LoewNextArabic",
                          fontStyle: FontStyle.normal,
                          fontSize: 22.0))),
            ),
            // Group Copy
            PositionedDirectional(
              top: 41,
              start: 41,
              child: SizedBox(
                  width: 121,
                  height: 38,
                  child: Stack(children: [
                    // Rectangle Copy 6
                    PositionedDirectional(
                      top: 0,
                      start: 0,
                      child: Container(
                          width: 121,
                          height: 38,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              color: const Color(0xffffffff))),
                    ),
                    // 34 SR
                    PositionedDirectional(
                      top: 5,
                      start: 18,
                      child: SizedBox(
                          width: 78,
                          height: 28,
                          child: Text("34 SR",
                              style: const TextStyle(
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "LoewNextArabic",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 22.0),
                              textAlign: TextAlign.center)),
                    )
                  ])),
            )
          ]))
    ])));
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
