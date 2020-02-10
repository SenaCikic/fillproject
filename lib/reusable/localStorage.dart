import 'package:fillproject/routes/arguments.dart';
import 'package:fillproject/routes/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStorage {
  Future<Null> loginUser(
      TextEditingController usernameC, String name, bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameC.text);
    name = usernameC.text;
    isLoggedIn = true;
    usernameC.clear();
  }

  void autoLogIn(BuildContext context, String name, bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('username');
    if (userId != null) {
      isLoggedIn = true;
      name = userId;
      Navigator.of(context).pushNamed(Homepage,
          arguments: PasswordArguments(
              email: '', password: '', phoneNo: '', username: ''));
      return;
    }
  }

  Future<Null> logout(String name, bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', null);
      name = '';
      isLoggedIn = false;
  }
}
