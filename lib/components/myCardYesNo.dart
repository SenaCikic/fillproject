import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myQuestion.dart';
import 'package:fillproject/components/myQuestionSAR.dart';
import 'package:fillproject/components/myYesNoChoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCardYesNo extends StatefulWidget {
  final String question, username;
  final int sar, target, usersSar;
  final List<dynamic> snapi;
  final int index;
  final Function() notifyParent;
  final DocumentSnapshot doc, snap;
  final ValueKey key;
  final bool isSar;

  MyCardYesNo(
      {this.question,
       this.key,
      this.sar,
      this.isSar,
      this.usersSar,
      this.index,
      this.snapi,
      this.snap,
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
        margin: EdgeInsets.only(left: 15, right: 15, top: 180),
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
              top: 41, start: 41, child: MyQuestionSAR(text: widget.sar.toString() + ' SAR')),
          PositionedDirectional(
              top: 170,
              start: 41,
              child: Container(
                child: Row(
                  children: <Widget>[
                    MyYesNoChoice(
                        choice: 'Yes',
                        snapi: widget.snapi,
                        usersSars: widget.usersSar,
                        sar: widget.sar,
                        isSar: widget.isSar,
                        snap: widget.snap,
                        index: widget.index,
                        notifyParent: widget.notifyParent,
                        target: widget.target,
                        doc: widget.doc,
                        username: widget.username),
                    MyYesNoChoice(
                        choice: 'No',
                        snapi: widget.snapi,
                         usersSars: widget.usersSar,
                        snap: widget.snap,
                        isSar: widget.isSar,
                        sar: widget.sar,
                        index: widget.index,
                        notifyParent: widget.notifyParent,
                        target: widget.target,
                        doc: widget.doc,
                        username: widget.username)
                  ],
                ),
              ))
        ]));
  }
}
