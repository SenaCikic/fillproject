import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myTextFormField.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/register/verifyPinPage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/myColor.dart';

class RegisterPage extends StatelessWidget {
  String phoneNo, smsCode, verificationId, username, name;
  bool isLoggedIn = false;

  TextEditingController phoneController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // signIn() {
    //   final AuthCredential credential = PhoneAuthProvider.getCredential(
    //       verificationId: verificationId, smsCode: smsCode);
    //   FirebaseAuth.instance.signInWithCredential(credential).then((user) {
    //     // Navigator.of(context).pushReplacementNamed(Dashboard, arguments: \);
    //   }).catchError((e) {
    //     print('Auth Credential Error : $e');
    //   });
    // }

    Widget  smsCodeDialog(BuildContext context) {
      return  VerifyPinPage(arguments:RegisterArguments(verId: verificationId, username: usernameController.text, phone: phoneController.text),);
      
      // showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (BuildContext context) {
      //       return new AlertDialog(
      //         title: Text("Enter SMS Code"),
      //         content: TextField(
      //           onChanged: (value) {
      //             this.smsCode = value;
      //           },
      //         ),
      //         contentPadding: EdgeInsets.all(10.0),
      //         actions: <Widget>[
      //           new FlatButton(
      //               onPressed: () {
      //                 FirebaseAuth.instance.currentUser().then((user) {
      //                   if (user != null) {
      //                     print('TU SAM 1');
      //                     Navigator.of(context).pop();
      //                     Navigator.of(context).pushReplacementNamed(Dashboard);
      //                   } else {
      //                     Navigator.of(context).pop();
      //                     signIn();
      //                   }
      //                 });
      //               },
      //               child: Text("DONE!"))
      //         ],
      //       );
      //     });
    }

    

    Future<void> verifyPhone() async {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        this.verificationId = verId;
      };

      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        Navigator.of(context).pushNamed(VerifyPin,arguments: RegisterArguments(verId: verificationId));
        // smsCodeDialog(context).then((value) {
        //   print("Signed IN!");
        // });
      };

      final PhoneVerificationCompleted verificationSuccess =
          (AuthCredential user) {
        print("DOBRO JE");
      };

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
    LoginStorage().loginUser(usernameController, name, isLoggedIn);
    print(phoneNo + "     OVO JE MOJ PHONE");
    print(username + "   OVO JE MOJ USERNAME");
    // MyValidation().registerValidation(username, phoneNo, context);
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
                  Container(
                    width: 280.0,
                    height: 60,
                    margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: MyTextFormField(
                        controller: usernameController,
                        label: MyText().labelUsername,
                        obscureText: false),
                  ),
                  Container(
                    width: 280.0,
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
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  
  void dispose() {
    phoneController.dispose();
    usernameController.dispose();
    dispose();
  }
}
