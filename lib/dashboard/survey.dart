import 'package:flutter/material.dart';

class Survey extends StatefulWidget {
  Survey({Key key}) : super(key: key);

  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text('Ovdje će biti SURVEY-i !!!'),
       ),
    );
  }
}