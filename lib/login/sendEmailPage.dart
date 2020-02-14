import 'dart:async';

import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myText.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailResetPage extends StatelessWidget {
  String email;
  int _btnCounter = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().black,
      appBar: new AppBar(
        title: new Text(""),
        backgroundColor: MyColor().black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25.0),
            child: SizedBox(
                width: 184,
                height: 28,
                child: Text("Reset password",
                    style: const TextStyle(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        fontFamily: "LoewNextArabic",
                        fontStyle: FontStyle.normal,
                        fontSize: 23.0),
                    textAlign: TextAlign.center)),
          ),
          Container(
            margin: EdgeInsets.only(top: 22.0, right: 73.0, left: 72.0),
            child: SizedBox(
                width: 269,
                height: 66,
                child: Text(
                    "If you do not know your current password, you may change it.",
                    style: const TextStyle(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w500,
                        fontFamily: "LoewNextArabic",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0),
                    textAlign: TextAlign.center)),
          ),
          Container(
              margin: EdgeInsets.only(
                  bottom: 20, top: 163.0, left: 54.0, right: 44.0),
              child: Container(
                width: ScreenUtil.instance.setWidth(316.0),
                height: ScreenUtil.instance.setHeight(92.0),
                margin: EdgeInsets.only(top: 20.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: false,
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 35.0),
                      labelText: MyText().labelEmail,
                      labelStyle: TextStyle(color: MyColor().white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(color: MyColor().white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(color: MyColor().white),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(
                          color: MyColor().error,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.5)),
                        borderSide: BorderSide(
                          color: MyColor().error,
                        ),
                      ),
                    ),
                    style: TextStyle(color: MyColor().white),
                    // validator: (email) =>
                    //     MyValidation().validateEmail(email, _btnCounter),
                  ),
                ),
              )),
          Container(
              width: ScreenUtil.instance.setWidth(316.0),
              height: ScreenUtil.instance.setHeight(67.0),
              margin: EdgeInsets.only(left: 46.0, right: 52.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(33.5),
                ),
                onPressed: () => onPressed(context),
                child: Text(MyText().btnEmail, style: TextStyle(fontSize: 18)),
              )),
        ],
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_btnCounter == 0) {
      Navigator.of(context).pushNamed(PasswordReset);
      _btnCounter = 1;
      Timer(Duration(seconds: 2), () {
        _btnCounter = 0;
      });
    }
  }
}
