import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/mySnackbar.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MyValidation {
  int snackCounter = 0;

  RegExp regexPassword = new RegExp(r'^(?=.*?[A-Z])(?=.*[0-9])(?=.{8,})');
  /// validacija za register screen
  ///
  /// email, username and phone validacija

  registerValidation(
      String username, String phone, BuildContext context) {
     if (username == '' || username == null) {
      if (snackCounter == 0) {
        MySnackbar()
            .showSnackbar(MyText().regUserSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (phone == '' || phone == null) {
      if (snackCounter == 0) {
        MySnackbar()
            .showSnackbar(MyText().regPhoneSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else {
      Navigator.of(context).pushNamed(VerifyPin,
          arguments: RegisterArguments(
               phone: phone, username: username));
    }
  }

  /// validacija za login
  ///
  /// username prazan ili null
  /// password manji od 8, prazan ili null
  loginValidation(String username, String password, String userExists,
      String passExists, BuildContext context) {
    if (username == '' || username == null) {
      if (snackCounter == 0) {
        MySnackbar()
            .showSnackbar(MyText().regUserSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    }else if (password == '' || password == null) {
      if (snackCounter == 0) {
        MySnackbar()
            .showSnackbar(MyText().regPassSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (password.length < 8) {
      if (snackCounter == 0) {
        MySnackbar().showSnackbar(
            MyText().regPassLengthSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else {
      Navigator.of(context).pushNamed(Dashboard,
          arguments: PasswordArguments(
              username: username, password: password, email: '', phone: ''));
    }
  }
  /// smsCode validacija
  ///
  /// code ne smije biti prazan, null ili manji od 6 karaktera
  smsCodeValidation(String code, BuildContext context, String email, String phone,
      String username){
    if (code == '' || code == null) {
      if (snackCounter == 0) {
        MySnackbar()
            .showSnackbar(MyText().smsEmptySnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (code.length < 6) {
      if (snackCounter == 0) {
        MySnackbar()
            .showSnackbar(MyText().smsLengthSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else {

      //TODO: Check if smsCode is valid! 
    
      // Navigator.of(context).pushNamed(Password,
      //     arguments: RegisterArguments(
      //         email: email, phone: phone, username: username));
    }
  }

  /// password validacija
  ///
  /// pass ne smije biti manji od 8 karaktera, prazan ili null
  passwordValidation(String password, BuildContext context, String email, String phone,
      String username) {
    if (password == '' || password == null) {
      if (snackCounter == 0) {
        MySnackbar()
            .showSnackbar(MyText().regPassSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (password.length < 8) {
      if (snackCounter == 0) {
        MySnackbar().showSnackbar(
            MyText().regPassLengthSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if(regexPassword.hasMatch(password) == false ){
      MySnackbar().showSnackbar(
            MyText().regexPasswordSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
    } else {
      Navigator.of(context).pushNamed(Dashboard,
          arguments: PasswordArguments(
              email: email,
              phone: phone,
              username: username,
              password: password));
    }
  }




  emailValidation(String email, String username, String phone, BuildContext context){
    if (email == '') {
      if (snackCounter == 0) {
        MySnackbar()
            .showSnackbar(MyText().regEmailSnack, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (!EmailValidator.validate(email, true)) {
      if (snackCounter == 0) {
        MySnackbar()
            .showSnackbar(MyText().validEmail, context, MyText().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    }
  }
}


