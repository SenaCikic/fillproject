

import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSignIn {
  /// Anonymous SIGN IN 
  /// 
  /// on SKIP BUTTON
  Future<void> signInAnonymously(String username) async {
    try {
       FirebaseCrud().createUser('', '', username, '', 0);
      await FirebaseAuth.instance.signInAnonymously();
     
    } catch (e) {
      print(e);
    }
  }
}