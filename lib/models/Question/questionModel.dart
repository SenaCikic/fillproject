import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Question {
  final ValueKey key;
  final String title;
  final int sar;
  final List<dynamic> choices;
  final String type;
  final int target;
  final List<dynamic> listOfUsernames;


  Question({this.choices, this.sar, this.title, this.type, this.target, this.listOfUsernames, this.key});

  factory Question.fromDocument(DocumentSnapshot doc) {
    return Question(
        choices: doc['choices'], 
        sar: doc['sar'], 
        title: doc['title'],
        type: doc['type'],
        target: doc['target'],
        listOfUsernames: doc['listOfUsernames'],
        key: ValueKey(doc['title']),  
     );
  }
}


