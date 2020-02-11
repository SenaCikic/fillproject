import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

String email;
int _btnCounter = 0;

class EmailPage extends StatelessWidget {
  final RegisterArguments emailArguments;
  final TextEditingController emailController = new TextEditingController();

  EmailPage({this.emailArguments});

  void dispose() { 
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(""),
        backgroundColor: MyColor().black,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(MyText().emailHeadline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: MyColor().white,
                  )),
              Text(MyText().fiveSar,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: MyColor().white,
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: Container(
                  width: 320.0,
                  height: 60,
                  margin: EdgeInsets.only(top: 20.0),
                  child: MyTextFormField(
                    controller: emailController,
                    label: MyText().labelEmail,
                    obscureText: true,
                  ),
                ),
              ),
              Container(
                width: 320.0,
                height: 60,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                     // onPressed(context);
                    },
                    child: Text(MyText().btnPassword)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
