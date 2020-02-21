import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String title;
  final int sar;
  final List<dynamic> choices;
  final String type;
  final int target;


  Question({this.choices, this.sar, this.title, this.type, this.target});

  factory Question.fromDocument(DocumentSnapshot doc) {
    return Question(
        choices: doc['choices'], 
        sar: doc['sar'], 
        title: doc['title'],
        type: doc['type'],
        target: doc['target']
     );
  }
}
