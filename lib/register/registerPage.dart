import 'dart:io';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/mySnackbar.dart';
import 'package:fillproject/components/myText.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:fillproject/utils/screenUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/myColor.dart';

class RegisterPage extends StatelessWidget {
  String phoneNo, smsCode, verificationId, username, name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoggedIn = false;

  TextEditingController phoneController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Constant().responsive(context);

    Future<void> verifyPhone() async {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        this.verificationId = verId;
      };

      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        Navigator.of(context).pushNamed(VerifyPin,
            arguments: RegisterArguments(
                verId: verificationId,
                username: usernameController.text,
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
      final _formState = _formKey.currentState;
      if (_formState.validate()) {
        LoginStorage().loginUser(usernameController, name, isLoggedIn);
        verifyPhone();
      }
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
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: Text(
                      MyText().registerHeadline,
                      style: TextStyle(
                          fontSize: 23,
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
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )),
                    Container(
                      width: 316.0,
                      height: 83,
                      margin: EdgeInsets.only(bottom: 19, left: 49, right: 49),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: usernameController,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                          labelText: MyText().labelUsername,
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
                        validator: (username) =>
                            MyValidation().validateUsername(username),
                      ),
                    ),
                    Container(
                      width: 316.0,
                      height: 83,
                      margin: EdgeInsets.only(left: 49, right: 49),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                          prefix: Text(
                            "+966",
                            style: TextStyle(color: MyColor().white),
                          ),
                          labelText: MyText().labelPhone,
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
                        validator: (phone) =>
                            MyValidation().validatePhone(phone),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
