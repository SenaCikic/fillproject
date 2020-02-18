import 'package:fillproject/components/questionsLevel1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = Firestore.instance;

class FirebaseJson {
  importJson(){
    QuestionsLevel1().questionLevel1.forEach((element) {
      db.collection('Questions')
      .add({'name': element['name'], 'type': element['type'], 'title': element['title'], 'choices': element['choices'],
      'target': element['target'], 'sar': element['sar']})
      .then((value) => { print('unos uspjesan')})
.catchError((err) {
  print(err);
});
    });
  }
}


