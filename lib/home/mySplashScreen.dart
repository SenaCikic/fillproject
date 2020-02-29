import 'package:fillproject/components/myText.dart';
import 'package:fillproject/home/homePage.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => new _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new SignUp(),
      title: new Text(
        MyText().fill,
        style: new TextStyle(
            fontSize: 70.0, color: Colors.white, fontFamily: 'RobotoMono'),
      ),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      onClick: () => new SignUp(),
      loaderColor: Colors.black,
      loadingText: new Text(
        MyText().builtBy,
        style: new TextStyle(
            fontSize: 23, color: Colors.white, fontFamily: 'RobotoMono'),
      ),
    );
  }
}
