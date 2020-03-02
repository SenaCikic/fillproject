/// Firebase CRUD  class
///
/// This class contains methods (CRUD) for the app.
///
/// Imports:
///   Cloud_firestore for connection to the firebase
///   Routes
///   Random String class for generating String which is used for custom username for anonymous users
///
/// Authors: Sena Cikic, Danis Preldzic, Adi Cengic, Jusuf Elfarahati
/// Tech387 - T2
/// Feb, 2020

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

final db = Firestore.instance;

class FirebaseCrud {
  /// create function
  ///
  /// upis u firestore collection
  createUser(String email, String phone, String username, String password,
      int sar) async {
    await db.collection('Users').add({
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'user_id': randomAlphaNumeric(15),
      'level': 1,
      'sar': sar,
    });
  }

  updatePassword(
      DocumentSnapshot doc, BuildContext context, String password) async {
    await db
        .collection('Users')
        .document(doc.documentID)
        .updateData({'password': '$password'});
    Navigator.of(context).pushNamed(Login);
  }

  // updateTarget(DocumentSnapshot doc, BuildContext context, int target) async {
  //   await db
  //       .collection('Questions')
  //       .document(doc.documentID)
  //       .updateData({'target': target});
  // }

  updateListOfUsernameAnswers(DocumentSnapshot doc, BuildContext context,
      String username, String choice) async {
    await db.collection('Questions').document(doc.documentID).updateData({
      'listOfUsernameAnswers': FieldValue.arrayUnion(['$username : $choice'])
    });
  }

  updateListOfUsernamesThatGaveAnswers(
      DocumentSnapshot doc, BuildContext context, String username) async {
    await db.collection('Questions').document(doc.documentID).updateData({
      'listOfUsernamesThatGaveAnswers': FieldValue.arrayUnion(['$username'])
    });
  }

  updateUsersSars(DocumentSnapshot doc, BuildContext context, int sar) async {
    await db
        .collection('Users')
        .document(doc.documentID)
        .updateData({'sar': sar});
  }
}
