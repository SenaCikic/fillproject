import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myQuestion.dart';
import 'package:fillproject/components/myQuestionSAR.dart';
import 'package:fillproject/components/myYesNoChoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCardYesNo extends StatefulWidget {
  final String question, username;
  final int sar, target;
  final List<dynamic> snapi;
  final int index;
  final Function() notifyParent;
  final DocumentSnapshot doc;
  final ValueKey key;

  MyCardYesNo(
      {this.question,
       this.key,
      this.sar,
      this.index,
      this.snapi,
      @required this.notifyParent,
      this.target,
      this.doc,
      this.username
      });

  @override
  _MyCardYesNoState createState() => _MyCardYesNoState();
}

class _MyCardYesNoState extends State<MyCardYesNo> {
  @override
  Widget build(BuildContext context) {
    return Container(
       key: widget.key,
        width: ScreenUtil.instance.setWidth(336.0),
        height: ScreenUtil.instance.setHeight(320.0),
        margin: EdgeInsets.only(bottom: 29.0, left: 15, right: 15, top: 180),
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
              top: 41, start: 41, child: MyQuestionSAR(text: '50 SAR')),
          PositionedDirectional(
              top: 200,
              start: 41,
              child: Row(
                children: <Widget>[
                  MyYesNoChoice(
                      choice: 'Yes',
                      snapi: widget.snapi,
                      index: widget.index,
                      notifyParent: widget.notifyParent,
                      target: widget.target,
                      doc: widget.doc,
                      username: widget.username),
                  MyYesNoChoice(
                      choice: 'No',
                      snapi: widget.snapi,
                      index: widget.index,
                      notifyParent: widget.notifyParent,
                      target: widget.target,
                      doc: widget.doc,
                      username: widget.username)
                ],
              ))
        ]));
  }
}
