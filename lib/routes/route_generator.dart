import 'package:fillproject/routes/route_constants.dart';
import 'package:fillproject/src/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/screens/homepage.dart';
import '../src/screens/loginSingUp.dart';
import '../src/screens/password.dart';
import '../src/screens/register.dart';
import '../src/screens/verifyPin.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    final args = settings.arguments;

    switch (settings.name) {
      case LoginAndSignUp:
        return MaterialPageRoute(builder: (_) => SignUp());
      case Register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case Verify:
        return MaterialPageRoute(builder: (_) => VerifyPin(arguments: args));
      case Password:
        return MaterialPageRoute(builder: (_) => SetPassword(arguments: args));
      case Homepage:
        return MaterialPageRoute(builder: (_) => DashboardPage(arguments: args));
      case Login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Container(
            child: Text('Error Screen'),
          ),
        ),
      );
    });
  }
}
