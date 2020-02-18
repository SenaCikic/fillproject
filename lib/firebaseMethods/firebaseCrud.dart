// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/material.dart';

final db = FirebaseDatabase.instance;

class FirebaseCrud {
  /// create function
  ///
  /// upis u firestore collection
  createUser(String email, String phone, String username, String userId,
      String password) async {
    await db.reference().child('1').set({
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'user_id': userId
    });
  }

  // updatePassword(
  //   DocumentSnapshot doc,
  //   BuildContext context,
  //   String password) async {
  //   await db.collection('Users').document(doc.documentID).updateData({
  //     'password': '$password'
  //   });
  //   print('update je uspjesan hehehehhe');
  //   Navigator.of(context).pushNamed(Login); 
  // }
  
}
