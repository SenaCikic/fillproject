import 'package:cloud_firestore/cloud_firestore.dart';

final db = Firestore.instance;

class FirebaseCrud {
  /// create function
  ///
  /// upis u firestore collection
  createUsers(String email, String phone, String username, String userID,
      String password) async {
    await db.collection('users').add({
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'user_id': userID
    });
  }
}
