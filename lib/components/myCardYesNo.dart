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
    margin: EdgeInsets.only(left: 10, top: 180, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: MyColor().black),
        child: Padding(
            padding: const EdgeInsets.only(left: 42.5, right: 40, top: 20, bottom: 10),          
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Container(
                child: MyQuestionSAR(text: widget.sar.toString() + ' SAR'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: MyQuestion(
                  question: widget.question),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
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
                          marginRight: 22.0,
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
                          marginRight: 0.0,
                          username: widget.username)
                    ],
                  ),
                )
          ]),
        ));
  }
}
