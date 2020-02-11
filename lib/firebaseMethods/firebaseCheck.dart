import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCheck {
  /// provjera da li username postoji u bazi
  ///
  Future<bool> doesNameAlreadyExist(String username) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
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
        .collection('users')
        .where('password', isEqualTo: password)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }
}
