/// Yes No Card class
///
/// This class contains model for flash yes and no question card.
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
      this.username});

  @override
  _MyCardYesNoState createState() => _MyCardYesNoState();
}

class _MyCardYesNoState extends State<MyCardYesNo> {
  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Container(
       key: widget.key,
        width: ScreenUtil.instance.setWidth(340.0),
        height: ScreenUtil.instance.setHeight(320.0),
    margin: EdgeInsets.only(left: 40 / pixelRatio, top: 400 / pixelRatio, right: 25 / pixelRatio),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: MyColor().black),
        child: Padding(
            padding: EdgeInsets.only(left: 120 / pixelRatio, right: 70 / pixelRatio, top: 30 / pixelRatio),          
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20 / pixelRatio),
                child: MyQuestionSAR(text: widget.sar.toString() + ' SAR'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20 / pixelRatio),
                child: MyQuestion(
                  question: widget.question,
                  containerHeight: ScreenUtil.instance.setHeight(90.0)),
              ),
              Container(
                margin: EdgeInsets.only(top: 40 / pixelRatio),
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
                          marginRight: 0,
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
                          marginRight: 100 / pixelRatio,
                          username: widget.username)
                    ],
                  ),
                )
              ]),
        ));
  }
}
