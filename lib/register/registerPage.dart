import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/myColor.dart';

class RegisterPage extends StatelessWidget {
  String email, phone, smsCode, verificationId, username, name;
  bool isLoggedIn = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    signIn() {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: smsCode);
      FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        Navigator.of(context).pushReplacementNamed(Dashboard);
      }).catchError((e) {
        print('Auth Credential Error : $e');
      });
    }

    Future<bool> smsCodeDialog(BuildContext context) {
      Navigator.of(context).pushNamed(VerifyPin,
          arguments: RegisterArguments(email: email, phone: phone));
    }

    Future<void> verifyPhone() async {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve =
          (String verificationId) {
        this.verificationId = verificationId;
      };
      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verificationId;
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
          phoneNumber: this.phone,
          codeAutoRetrievalTimeout: autoRetrieve,
          codeSent: smsCodeSent,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verifiedSuccess,
          verificationFailed: veriFailed);
    }

    onFieldSubmitted(BuildContext context) {
      phone = phoneController.text;
      email = emailController.text;
      username = usernameController.text;
      LoginStorage().loginUser(usernameController, name, isLoggedIn);

      /// validacija
      MyValidation().registerValidation(username, phone, context);
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
        builder: (context) => SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Center(
                      child: Text(
                    MyText().registerHeadline,
                    style: TextStyle(
                      fontSize: 20,
                      color: MyColor().white,
                    ),
                    textAlign: TextAlign.center,
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Center(
                      child: Text(
                    MyText().registerSubtitle,
                    style: TextStyle(
                        color: MyColor().white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                  // Container(
                  //   width: 280.0,
                  //   height: 60,
                  //   margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  //   child: MyTextFormField(
                  //       controller: emailController,
                  //       label: MyText().labelEmail,
                  //       obscureText: false),
                  // ),
                  Container(
                    width: ScreenUtil.instance.setWidth(280.0),
                    height: 60,
                    margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: MyTextFormField(
                        controller: usernameController,
                        label: MyText().labelUsername,
                        obscureText: false),
                  ),
                  Container(
                    width: ScreenUtil.instance.setWidth(280.0),
                    height: 60,
                    margin: EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      decoration: InputDecoration(
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
                      onFieldSubmitted: (value) => onFieldSubmitted(context),
                      style: TextStyle(color: MyColor().white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
