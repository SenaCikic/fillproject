import 'package:fillproject/components/myMCQChoice.dart';
import 'package:fillproject/dashboard/dashboard.dart';
import 'package:fillproject/dashboard/profile.dart';
import 'package:fillproject/dashboard/survey.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

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
        key: PageStorageKey('Page1'),
        arguments: PasswordArguments(
          email: arguments.email,
          password: arguments.password,
          phone: arguments.phone,
          username: arguments.username,
        )),
    Survey(
      key: PageStorageKey('Page2'),
    ),
    Profile(
      key: PageStorageKey('Page3'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add), title: Text('First Page')),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Second Page')),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Second Page'))
        ],
      );

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages()[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
