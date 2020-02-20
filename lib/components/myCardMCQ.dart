import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myMCQChoice.dart';
import 'package:fillproject/components/myQuestion.dart';
import 'package:fillproject/components/myQuestionSAR.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCardMCQ extends StatefulWidget {
  final String question;
  final int sar;
  final List<dynamic> snapi;
  final int index;
  final List<dynamic> choices;
  final Function() notifyParent;

  MyCardMCQ({this.sar, this.question, this.choices, this.index, this.snapi, @required this.notifyParent});

  @override
  _MyCardMCQState createState() => _MyCardMCQState();
}

class _MyCardMCQState extends State<MyCardMCQ> {
  final List<dynamic> choicesEnd = [];


  @override
  Widget build(BuildContext context) {
    getChoices(widget.choices);
    return Container(
    key: UniqueKey(),
    width: ScreenUtil.instance.setWidth(336.0),
    margin: EdgeInsets.only(bottom: 29, right: 15, left: 15, top: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: MyColor().black),
    child: Stack(children: <Widget>[
      PositionedDirectional(
          top: 98,
          start: 49,
          child: MyQuestion(
            question: widget.question,
          )),
      PositionedDirectional(
          top: 41, start: 41, child: MyQuestionSAR(text: '${widget.sar} SAR')),
      PositionedDirectional(
          top: 180,
          start: 41,
          child: Container(
            height: ScreenUtil.instance.setHeight(250.0),
            width: ScreenUtil.instance.setWidth(260.0),
            child: ListView(
                children: choicesEnd
                    .map((item) => MyMCQChoice(choice: item, snapi: widget.snapi, index: widget.index, notifyParent: widget.notifyParent ))
                    .toList()),
          ))
    ]));
  }

  getChoices(List<dynamic> choices) {
    for (int i = 0; i < choices.length; i++) {
      choicesEnd.add(choices[i]['text']);
    }
  }
}
