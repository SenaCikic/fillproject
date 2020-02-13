import 'package:cloud_firestore/cloud_firestore.dart';

final db = Firestore.instance;

class FirebaseCrud {
  /// create function
  ///
  /// upis u firestore collection
  createUser(String email, String phone, String username, String userId,
      String password) async {
    await db.collection('Users').add({
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'user_id': userId
    });
  }
}
