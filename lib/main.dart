import 'package:fillproject/src/screens/password.dart';
import 'package:fillproject/src/screens/homepage.dart';
import 'package:fillproject/src/screens/loginSingUp.dart';
import 'package:fillproject/src/screens/register.dart';
import 'package:flutter/material.dart';

void main() => runApp(FillApp());

class FillApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final DashboardPage args = ModalRoute.of(context).settings.arguments;


    return MaterialApp(
        routes: <String, WidgetBuilder> {

    // '/homepage': (BuildContext context) => DashboardPage(),
    //       '/landingpage': (BuildContext context) => RegisterPage(),
    //       '/setupPassword': (BuildContext context) => SetPassword(),
    //       DashboardPage.routeName: (context) => DashboardPage(), // tu treba fino slati
        },
      home: Scaffold(
          body: SignUp()

      ),
    );
  }
}
