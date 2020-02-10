import 'package:fillproject/reusable/colors.dart';
import 'package:fillproject/reusable/localStorage.dart';
import 'package:fillproject/reusable/text.dart';
import 'package:fillproject/reusable/textFormField.dart';
import 'package:fillproject/reusable/validation.dart';
import 'package:fillproject/routes/arguments.dart';
import 'package:fillproject/routes/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  String email, phoneNo, smsCode, verificationId, username, name;
  bool isLoggedIn = false;

  TextEditingController emailC = new TextEditingController();
  TextEditingController phoneC = new TextEditingController();
  TextEditingController usernameC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    signIn() {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: smsCode);
      FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        Navigator.of(context).pushReplacementNamed(Homepage);
      }).catchError((e) {
        print('Auth Credential Error : $e');
      });
    }

    Future<bool> smsCodeDialog(BuildContext context) {
      Navigator.of(context).pushNamed(Verify,
          arguments: RegisterArguments(email: email, phoneNo: phoneNo));

    }

    Future<void> verifyPhone() async {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        this.verificationId = verId;
      };
      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        smsCodeDialog(context).then((value) {
          print('Signed in');
        });
      };
      final PhoneVerificationCompleted verifiedSuccess = (AuthCredential user) {
        print('verified');
      };
      final PhoneVerificationFailed veriFailed = (AuthException exception) {
        print('${exception.message}');
      };
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          codeAutoRetrievalTimeout: autoRetrieve,
          codeSent: smsCodeSent,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verifiedSuccess,
          verificationFailed: veriFailed);
    }

    return Scaffold(
      backgroundColor: ColorsStyle().black,
      body: Builder(
        builder: (context) => Center(
          child: Container(
            margin: EdgeInsets.only(top: 220.0),
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(
                  Texts().registerHeadline,
                  style: TextStyle(fontSize: 20, color: ColorsStyle().white),
                )),
                Center(
                    child: Text(
                  Texts().registerSubtitle,
                  style: TextStyle(color: ColorsStyle().white),
                )),
                Container(
                  width: 250.0,
                  margin: EdgeInsets.only(top: 50.0),
                  child: TextFormF(
                      controller: emailC,
                      label: Texts().labelEmail,
                      obscureText: false),
                ),
                Container(
                  width: 250.0,
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextFormF(
                      controller: usernameC,
                      label: Texts().labelUsername,
                      obscureText: false),
                ),
                Container(
                  width: 250.0,
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    controller: phoneC,
                    decoration: InputDecoration(
                      labelText: Texts().labelPhone,
                      labelStyle: TextStyle(color: ColorsStyle().white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        borderSide: BorderSide(color: ColorsStyle().white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        borderSide: BorderSide(color: ColorsStyle().white),
                      ),
                    ),
                    onFieldSubmitted: (value) => onFieldSubmitted(context),
                    style: TextStyle(color: ColorsStyle().white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onFieldSubmitted(BuildContext context) {
    phoneNo = phoneC.text;
    email = emailC.text;
    username = usernameC.text;
    LoginStorage().loginUser(usernameC, name, isLoggedIn);
    /// validacija
    ValidateFields().registerVal(email, username, phoneNo, context);
    //verifyPhone();
  }
}
