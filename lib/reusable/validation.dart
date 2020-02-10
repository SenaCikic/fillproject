import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:fillproject/reusable/snackbar.dart';
import 'package:fillproject/reusable/text.dart';
import 'package:fillproject/routes/arguments.dart';
import 'package:fillproject/routes/route_constants.dart';
import 'package:flutter/cupertino.dart';
// import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

///counteri
/// snackbar
int snackCounter = 0;

class ValidateFields {
  /// validacija za register screen
  ///
  /// email, username and phone validacija
  registerVal(
      String email, String username, String phone, BuildContext context) {
    if (email == '') {
      if (snackCounter == 0) {
        Snackbars()
            .showSnackbar(Texts().regEmailSnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (!EmailValidator.validate(email, true)) {
      if (snackCounter == 0) {
        Snackbars()
            .showSnackbar(Texts().validEmail, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (username == '' || username == null) {
      if (snackCounter == 0) {
        Snackbars()
            .showSnackbar(Texts().regUserSnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (phone == '' || phone == null) {
      if (snackCounter == 0) {
        Snackbars()
            .showSnackbar(Texts().regPhoneSnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else {
      Navigator.of(context).pushNamed(Verify,
          arguments: RegisterArguments(
              email: email, phoneNo: phone, username: username));
    }
  }

  /// validacija za login
  ///
  /// username prazan ili null
  /// password manji od 8, prazan ili null
  loginVal(String username, String password, String userExists,
      String passExists, BuildContext context) {
    if (username == '' || username == null) {
      if (snackCounter == 0) {
        Snackbars()
            .showSnackbar(Texts().regUserSnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    }else if (password == '' || password == null) {
      if (snackCounter == 0) {
        Snackbars()
            .showSnackbar(Texts().regPassSnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (password.length < 8) {
      if (snackCounter == 0) {
        Snackbars().showSnackbar(
            Texts().regPassLengthSnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else {
      Navigator.of(context).pushNamed(Homepage,
          arguments: PasswordArguments(
              username: username, password: password, email: '', phoneNo: ''));
    }
  }
  /// smsCode validacija
  ///
  /// code ne smije biti prazan, null ili manji od 6 karaktera
  smsCodeVal(String code, BuildContext context, String email, String phone,
      String username) {
    if (code == '' || code == null) {
      if (snackCounter == 0) {
        Snackbars()
            .showSnackbar(Texts().smsEmptySnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (code.length < 6) {
      if (snackCounter == 0) {
        Snackbars()
            .showSnackbar(Texts().smsLengthSnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else {
      Navigator.of(context).pushNamed(Password,
          arguments: RegisterArguments(
              email: email, phoneNo: phone, username: username));
    }
  }

  /// password validacija
  ///
  /// pass ne smije biti manji od 8 karaktera, prazan ili null
  passwordVal(String password, BuildContext context, String email, String phone,
      String username) {
    if (password == '' || password == null) {
      if (snackCounter == 0) {
        Snackbars()
            .showSnackbar(Texts().regPassSnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else if (password.length < 8) {
      if (snackCounter == 0) {
        Snackbars().showSnackbar(
            Texts().regPassLengthSnack, context, Texts().snackUndo);
        snackCounter = 1;
        Timer(Duration(seconds: 2), () {
          snackCounter = 0;
        });
      }
    } else {
      Navigator.of(context).pushNamed(Homepage,
          arguments: PasswordArguments(
              email: email,
              phoneNo: phone,
              username: username,
              password: password));
    }
  }
}


