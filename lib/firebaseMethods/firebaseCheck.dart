import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCheck {



  /// provjera da li username postoji u bazi
  ///
  Future<bool> doesNameAlreadyExist(String username) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('Users')
        .where('username', isEqualTo: username)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }

  /// provjera da li password postoji u bazi
  ///
  Future<bool> doesPassAlreadyExist(String password) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('Users')
        .where('password', isEqualTo: password)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }

  /// provjera da li broj postoji u bazi
  ///
  Future<bool> doesNumberAlreadyExist(String phone) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('Users')
        .where('phone', isEqualTo: phone)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }

  /// provjera da li email postoji u bazi
  ///
  Future<bool> doesEmailAlreadyExist(String email) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }

/// pomocu metode [getUser] na osnovu unesenog emaila u resetPassword kupimo usera
/// i updatujemo password
  Future getUser(String email) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Users')
        .where('email', isEqualTo: email)
        .getDocuments();
    return qn.documents;
  }

  
}
