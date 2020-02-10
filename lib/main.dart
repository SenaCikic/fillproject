import 'package:fillproject/routes/route_constants.dart';
import 'package:fillproject/routes/route_generator.dart';
import 'package:fillproject/src/screens/loginSingUp.dart';
import 'package:flutter/material.dart';

void main() => runApp(FillApp());

class FillApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginAndSignUp,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Scaffold(body: SignUp()),
    );
  }
}
