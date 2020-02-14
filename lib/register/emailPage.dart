import 'dart:async';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:fillproject/utils/screenUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String email;
int _btnCounter = 0;

class EmailPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterArguments arguments;
  final TextEditingController emailController = new TextEditingController();

  EmailPage({this.arguments});

  @override
  Widget build(BuildContext context) {
    Constant().responsive(context);
    return Scaffold(
      appBar: new AppBar(
        title: new Text(""),
        backgroundColor: MyColor().black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushNamed(VerifyPin);
          },
        ),
      ),
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => GestureDetector(
                  child: SingleChildScrollView(
                    child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 28, bottom: 35),
                    child: Text(MyText().emailHeadline,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(23.0),
                          color: MyColor().white,
                        )),
                  ),
                  Text(MyText().fiveSar,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ScreenUtil.instance.setSp(40.0),
                        color: MyColor().white,
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 20, top: 20),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(color: MyColor().white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(color: MyColor().white),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(
                                  color: MyColor().error,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(
                                  color: MyColor().error,
                                ),
                              ),
                            ),
                            style: TextStyle(color: MyColor().white),
                            validator: (email) =>
                                MyValidation().validateEmail(email, _btnCounter),
                          ),
                        ),
                      )),
                  Container(
                      width: ScreenUtil.instance.setWidth(316.0),
                      height: ScreenUtil.instance.setHeight(67.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(33.5),
                        ),
                        onPressed: () => onPressed(context),
                        child:
                            Text(MyText().btnEmail, style: TextStyle(fontSize: 18)),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    email = emailController.text;
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      if (_btnCounter == 0) {
        Navigator.of(context).pushNamed(Password,
            arguments: RegisterArguments(
              email: email,
              phone: arguments.phone,
              username: arguments.username,
            ));
        _btnCounter = 1;
        Timer(Duration(seconds: 2), () {
          _btnCounter = 0;
        });
      }
    }
  }
}
