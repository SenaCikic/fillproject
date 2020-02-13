import 'dart:io';

import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/mySnackbar.dart';
import 'package:fillproject/components/myText.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/register/verifyPinPage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:fillproject/utils/screenUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/myColor.dart';

class RegisterPage extends StatelessWidget {
  String phoneNo, smsCode, verificationId, username, name;
  bool isLoggedIn = false;
  RegExp regexUsername = new RegExp(r' /^\S*$/'); //OVO DANISE DODATI

  TextEditingController phoneController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

        Constant().responsive(context);


    Widget smsCodeDialog(BuildContext context) {
      return VerifyPinPage(
        arguments: RegisterArguments(
            verId: verificationId,
            username: usernameController.text,
            phone: phoneController.text),
      );
    }

    Future<void> verifyPhone() async {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        this.verificationId = verId;
      };

      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        Navigator.of(context).pushNamed(VerifyPin,
            arguments: RegisterArguments(
                verId: verificationId,
                username: username,
                phone: phoneController.text));
      };

      final PhoneVerificationCompleted verificationSuccess =
          (AuthCredential user) {};

      final PhoneVerificationFailed verificationFailed =
          (AuthException exception) {
        print('${exception.message}');
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationSuccess,
          verificationFailed: verificationFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: autoRetrieve);
    }

    onFieldSubmitted(BuildContext context) {
      phoneNo = "+" +
          phoneController
              .text; //must change !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      username = usernameController.text;
      if (regexUsername.hasMatch(username) == false) {
        ///ovo dodati DANISE
      }

      ///ovo dodati DANISE

      LoginStorage().loginUser(usernameController, name, isLoggedIn);
      verifyPhone();
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text(""),
        backgroundColor: MyColor().black,
        centerTitle: true,
      ),
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                child: Column(children: <Widget>[
                  Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 28.0),
                    child: Text(
                      MyText().registerHeadline,
                      style: TextStyle(
                        fontSize: ScreenUtil.instance.setSp(23.0),
                        color: MyColor().white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 61.0, bottom: 59),
                    child: Text(
                      MyText().registerSubtitle,
                      style: TextStyle(
                        color: MyColor().white,
                        fontSize: ScreenUtil.instance.setSp(40.0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Container(
                    width:ScreenUtil.instance.setWidth(316.0),
                    height: ScreenUtil.instance.setHeight(83.0),
                    margin: EdgeInsets.only(bottom: 19, left: 49, right: 49),
                    child: MyTextFormField(
                        controller: usernameController,
                        label: MyText().labelUsername,
                        obscureText: false),
                  ),
                  Container(
                    width:ScreenUtil.instance.setWidth(316.0),
                    height: ScreenUtil.instance.setHeight(83.0),
                    margin: EdgeInsets.only(left: 49, right: 49),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                        prefix: Text(
                          "+966",
                          style: TextStyle(color: MyColor().white),
                        ),
                        labelText: MyText().labelPhone,
                        labelStyle: TextStyle(color: MyColor().white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(color: MyColor().white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(color: MyColor().white),
                        ),
                      ),
                      onFieldSubmitted: (value) async {
                        try {
                          final result =
                              await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            onFieldSubmitted(context);
                          }
                        } on SocketException catch (_) {
                          MySnackbar().showSnackbar(MyText().checkConnection,
                              context, MyText().snackUndo);
                        }
                      },
                      style: TextStyle(color: MyColor().white),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
