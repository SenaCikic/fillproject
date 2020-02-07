import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {


  String phoneNo;
  String smsCode;
  String verificationId;

  @override
  Widget build(BuildContext context) {
    signIn() {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId,
          smsCode: smsCode);
      FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        Navigator.of(context).pushReplacementNamed('/homepage');
      }).catchError((e) {
        print('Auth Credential Error : $e');
      });
    }

    Future<bool> smsCodeDialog(BuildContext context) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: Text('Enter sms Code'),
              content: TextField(
                onChanged: (value) {
                  this.smsCode = value;
                },
              ),
              contentPadding: EdgeInsets.all(10.0),
              actions: <Widget>[
                new FlatButton(
                  child: Text('Done'),
                  onPressed: () {
                    FirebaseAuth.instance.currentUser().then((user) {
                      if (user != null) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed('/setupPassword');
                      } else {
                        Navigator.of(context).pop();
                        signIn();
                      }
                    });
                  },
                )
              ],
            );
          });
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
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child: Text("Register and start making money",
                style: TextStyle(fontSize: 30,),)),
              Center(child: Text("3 SAR")),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),

              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Phone number"),
                onFieldSubmitted: (value) {
                  this.phoneNo = value;
                  verifyPhone();
                },

              ),

            ],
          ),
        ),
      ),
    );
  }
}
