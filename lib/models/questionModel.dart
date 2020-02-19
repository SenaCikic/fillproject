import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String title;
  final int sar;
  final List<dynamic> choices;
  final Function remove;
  final int index;

  Question({this.choices, this.sar, this.title, this.remove, this.index});

  factory Question.fromDocument(DocumentSnapshot doc) {
    return Question(
        choices: doc['choices'], 
        sar: doc['sar'], 
        title: doc['title']
     );
  }
}
