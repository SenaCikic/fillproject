import 'package:fillproject/src/screens/homepage.dart';
import 'package:flutter/material.dart';
 

class SetPassword extends StatelessWidget {
  static const routeName = '/extractArguments';

  String password;
  SetPassword({this.password});

  TextEditingController controllerPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: TextFormField(
                  controller: controllerPassword,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: Text('By tapping Sing Up & Accept, you acknoledge that you have read the Privacy Policy and agree to the Terms of Services')
              ),
              RaisedButton(onPressed: () {
                password =controllerPassword.text;

             //   Navigator.pushNamed(context, routeName, arguments: DashboardPage(password: password,));
                Navigator.pushNamed(
                    context,
                    DashboardPage.routeName,
                    arguments: password,
                );
              },
              child: Text('Sign Up & Accept'),
              )
            ],
          ),
      ),
    );
  }
}