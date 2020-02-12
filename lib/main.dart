import 'package:fillproject/home/mySplashScreen.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:fillproject/routes/routeGenerator.dart';
import 'package:flutter/material.dart';

void main() => runApp(FillApp());

class FillApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Scaffold(body: MySplashScreen()),
    );
  }
}



