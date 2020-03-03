/// Multiple Choice Question  class
///
/// This class contains model for flash muliple choice question card.
///
/// Imports:
///   MyColor constant class with all colors
///   Cloud_firestore for connection to the firebase
///   ScreenUtil class for respnsive desing
///
/// Authors: Sena Cikic, Danis Preldzic, Adi Cengic, Jusuf Elfarahati
/// Tech387 - T2
/// Feb, 2020

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/constants/myColor.dart';
import 'package:fillproject/components/myMCQChoice.dart';
import 'package:fillproject/components/myQuestion.dart';
import 'package:fillproject/components/myQuestionSAR.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCardMCQ extends StatefulWidget {
  final String question, username;
  final int sar, target, usersSar;
  final List<dynamic> snapi;
  final int index;
  final List<dynamic> choices;
  final Function() notifyParent;
  DocumentSnapshot doc;
  DocumentSnapshot snap;
  final ValueKey key;
  final bool isSar;

  MyCardMCQ(
      {this.sar,
      this.isSar,
      this.usersSar,
      this.snap,
      this.key,
      this.question,
      this.choices,
      this.index,
      this.snapi,
      @required this.notifyParent,
      this.target,
      this.doc,
      this.username});

  @override
  _MyCardMCQState createState() => _MyCardMCQState();
}

class _MyCardMCQState extends State<MyCardMCQ> {
  final List<dynamic> choicesEnd = [];

  @override
  void initState() {
    getChoices(widget.choices);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Container(
        key: widget.key,
        width: ScreenUtil.instance.setWidth(340.0),
        height: ScreenUtil.instance.setHeight(405.0),
        margin: EdgeInsets.only(left: 40 / pixelRatio, top: 10 / pixelRatio, right: 25 / pixelRatio),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: MyColor().black),
        child: Padding(
          padding: EdgeInsets.only(left: 140 / pixelRatio, right: 140 / pixelRatio, top: 30 / pixelRatio),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10 / pixelRatio),
                child: MyQuestionSAR(text: '${widget.sar} SAR'),
              ),
              Container(
                margin: EdgeInsets.only(top: 10 / pixelRatio),
                child: MyQuestion(
                  question: widget.question,
                  containerHeight: ScreenUtil.instance.setHeight(110.0)),
              ),
              Container(
                height: ScreenUtil.instance.setHeight(220.0),
                width: ScreenUtil.instance.setWidth(260.0),
                margin: EdgeInsets.only(top: 5 / pixelRatio),
                child: Column(
                      children: choicesEnd
                          .map((item) => MyMCQChoice(
                              choice: item,
                              isSar: widget.isSar,
                              snapi: widget.snapi,
                              index: widget.index,
                              notifyParent: widget.notifyParent,
                              target: widget.target,
                              doc: widget.doc,
                              username: widget.username,
                              sar: widget.sar,
                              usersSar: widget.usersSar,
                              snap: widget.snap))
                          .toList()),
                ),
              ]),
        ));
  }

  getChoices(List<dynamic> choices) {
    for (int i = 0; i < choices.length; i++) {
      choicesEnd.add(choices[i]['text']);
    }
  }
}
