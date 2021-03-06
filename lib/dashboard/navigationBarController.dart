/// Navigation Bar Controller class
///
/// This class contains Layout for navigation bar.
///
/// Imports:
///   MyColor constant class with all colors
///   ScreenUtil class for respnsive desing
///   Routes
///   Other pages like Dashboard, Profile and Survey
///
/// Authors: Sena Cikic, Danis Preldzic, Adi Cengic, Jusuf Elfarahati
/// Tech387 - T2
/// Feb, 2020

import 'dart:async';
import 'package:fillproject/components/constants/imageConstants.dart';
import 'package:fillproject/components/constants/myColor.dart';
import 'package:fillproject/dashboard/dashboard.dart';
import 'package:fillproject/dashboard/profile.dart';
import 'package:fillproject/dashboard/survey.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

bool isTab1Selected = true;
bool isTab2Selected = false;
bool isLoading = true;

class BottomNavigationBarController extends StatefulWidget {
  final PasswordArguments arguments;

  BottomNavigationBarController({Key key, this.arguments}) : super(key: key);
  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState(arguments: arguments);
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final PasswordArguments arguments;
  _BottomNavigationBarControllerState({Key key, this.arguments});

  List<Widget> pages() => [
        DashboardPage(
            arguments: PasswordArguments(
          email: arguments.email,
          password: arguments.password,
          phone: arguments.phone,
          username: arguments.username,
        )),
        Survey(),
        Profile(),
      ];

  final items = [
    BottomNavigationBarItem(
      icon: isTab1Selected
          ? ImageIcon(AssetImage(imageTab1))
          : ImageIcon(AssetImage(imageTab1)),
      title: Text('_______________'),
    ),
    BottomNavigationBarItem(
      icon: isTab2Selected
          ? ImageIcon(AssetImage(imageTab2))
          : ImageIcon(AssetImage(imageTab2)),
      title: Text('_______________'),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle), title: Text('_______________'))
  ];

  int currentIndex = 1;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    if (currentIndex == 0) {
      isTab1Selected = true;
      isTab2Selected = false;
    } else if (currentIndex == 1) {
      isTab1Selected = false;
      isTab2Selected = true;
    } else if (currentIndex == 2) {
      isTab1Selected = false;
      isTab2Selected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: MyColor().black,
          unselectedItemColor: MyColor().unselectedItemColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: items,
          currentIndex: currentIndex,
          onTap: onTap),
      body: isLoading
          ? Center(
              child: isLoadingCircular(),
            )
          : IndexedStack(
              index: currentIndex,
              children: pages(),
            ),
    );
  }

  /// function for loader
  ///
  /// this function returns [CircularProgressIndicator]
  /// and after 1 second the variable that controls indicator is set to false
  isLoadingCircular() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    return CircularProgressIndicator(
      backgroundColor: MyColor().black,
    );
  }
}
