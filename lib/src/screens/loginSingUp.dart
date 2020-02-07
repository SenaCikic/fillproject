import 'package:fillproject/src/screens/register.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(child: Text("fill", style: TextStyle(fontSize: 30,),)),
                Center(child: Text("Register and get 5 SAR")),
                RaisedButton(
                    onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    child: Text('Sign up')),
                RaisedButton(
                    onPressed: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => UserAndPass()));
                    },
                    child: Text('Sign in')),
              ],
            ),
        ),
      ),
    );
  }
}
