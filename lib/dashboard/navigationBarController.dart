import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/dashboard/dashboard.dart';
import 'package:fillproject/dashboard/profile.dart';
import 'package:fillproject/dashboard/survey.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

bool isTab1Selected = true;
bool isTab2Selected = false;

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
          ? ImageIcon(AssetImage('assets/images/tab1.png'))
          : ImageIcon(AssetImage('assets/images/tab1_1.png')),
      title: Text('_______________'),
    ),
    BottomNavigationBarItem(
      icon: isTab2Selected
          ? ImageIcon(AssetImage('assets/images/tab2.png'))
          : ImageIcon(AssetImage('assets/images/tab2_2.png')),
      title: Text('_______________'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle), 
      title: Text('_______________')
    )
  ];

  int currentIndex = 0;

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
      body: IndexedStack(
        index: currentIndex,
        children: pages(),
      ),
    );
  }
}
