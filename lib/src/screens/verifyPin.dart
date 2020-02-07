import 'package:fillproject/src/screens/password.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

String verificationCode;

class VerifyPin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
               child: PinEntryTextField(
                 fields: 6, // end onSubmit
              ),    
              ),
              RaisedButton(onPressed: (){
              
                Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SetPassword()));
              }, child:Text('Verify pin'))
            ],
          )
      ),
    );
  }
}