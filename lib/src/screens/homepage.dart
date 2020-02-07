
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = '/homepage';

   String password;
   DashboardPage({this.password});

  @override
  _DashboardPageState createState() => _DashboardPageState(password: password);
}

class _DashboardPageState extends State<DashboardPage> {

  String password;
  _DashboardPageState({this.password});

  String uid = '';

  getUid() {}

  @override
  void initState() {

    this.uid = '';
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this.uid = val.uid;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Dashboard'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('Set up a password and start getting!'),
                SizedBox(
                  height: 15.0,
                ),
                new Text('Moj email je: ______ i moj password je $password'),
                SizedBox(
                  height: 15.0,
                ),
                new OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.red, style: BorderStyle.solid, width: 3.0),
                  child: Text('Logout'),
                  onPressed: () {
                    print("OVO JE MOJ PASSWORD: " + password);
                    FirebaseAuth.instance.signOut().then((action) {
                      Navigator
                          .of(context)
                          .pushReplacementNamed('/landingpage');
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}