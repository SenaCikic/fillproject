import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

final db = Firestore.instance;

class FirebaseCrud {
  /// create function
  ///
  /// upis u firestore collection
  createUser(String email, String phone, String username,
      String password) async {
    await db.collection('Users').add({
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'user_id': randomAlphaNumeric(15),
      'level': "1",
    });
  }

  updatePassword(
    DocumentSnapshot doc,
    BuildContext context,
    String password) async {
    await db.collection('Users').document(doc.documentID).updateData({
      'password': '$password'
    });
    Navigator.of(context).pushNamed(Login); 
  }

  updateTarget(
    DocumentSnapshot doc,
    BuildContext context,
    int target) async {
    await db.collection('Questions').document(doc.documentID).updateData({
      'target': target
    });
    print('update je uspjesan hehehehhe');
  }
  
}
