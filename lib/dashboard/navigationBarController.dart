import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/dashboard/dashboard.dart';
import 'package:fillproject/dashboard/profile.dart';
import 'package:fillproject/dashboard/survey.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

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
      icon: Icon(Icons.announcement),
      title: Text(''),
    ),
    BottomNavigationBarItem(icon: Icon(Icons.view_week), title: Text('')),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text(''))
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
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
      body: IndexedStack(
        index: currentIndex,
        children: pages(),
      ),
    );
  }
}
