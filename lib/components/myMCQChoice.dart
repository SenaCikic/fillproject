import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:fillproject/models/Question/questionSkelet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../globals.dart';

class MyMCQChoice extends StatefulWidget {
  DocumentSnapshot doc;
  DocumentSnapshot snap;
  final String choice, username;
  int index, target, sar, usersSar;
  final Function() notifyParent;
  final List<dynamic> snapi;
  final bool isSar;
  final bottomMargin;

  MyMCQChoice({
    this.choice,
    this.isSar,
    this.snapi,
    this.index,
    this.notifyParent,
    this.target,
    this.doc,
    this.username,
    this.sar,
    this.snap,
    this.usersSar,
    this.bottomMargin
  });

  @override
  _MyMCQChoiceState createState() => _MyMCQChoiceState();
}

class _MyMCQChoiceState extends State<MyMCQChoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(257.0),
        height: ScreenUtil.instance.setHeight(60.0),
        margin: EdgeInsets.only(bottom: 15.0),
        alignment: Alignment.center,
        child: Container(
          width: ScreenUtil.instance.setWidth(257.0),
          height: ScreenUtil.instance.setHeight(53.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(28.0),
            ),
            hoverColor: isTapped ? MyColor().white : MyColor().black,
            elevation: 0,
            color: isTapped ? MyColor().white : MyColor().black,
            onPressed: () async {
              setState(() {
                isTapped = true;
              });
           
                Timer(Duration(milliseconds: 50), () {
                  onPressed();
                });
              
            },
            child: Text(widget.choice,
                style: TextStyle(
                    color: isTapped ? MyColor().black : MyColor().white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "LoewNextArabic",
                    fontStyle: FontStyle.normal,
                    fontSize: ScreenUtil.instance.setSp(15.0))),
          ),
        ),
        decoration: BoxDecoration(
            color: isTapped ? MyColor().white : MyColor().black,
            border: Border.all(color: MyColor().white),
            borderRadius: BorderRadius.all(Radius.circular(33.5))));
  }

  onPressed() {
    int counter = widget.target - 1;
    widget.usersSar += widget.sar;
    saroviOffline += widget.sar;
    FirebaseCrud().updateTarget(widget.doc, context, counter);

    /// update sarova na osnovu da li je app online ili offline
    ///
    /// online = [widget.usersSar]
    /// offline = [saroviOffline]
    if (widget.isSar) {
      FirebaseCrud().updateUsersSars(widget.snap, context, saroviOffline);
    } else {
      FirebaseCrud().updateUsersSars(widget.snap, context, widget.usersSar);
    }

    FirebaseCrud().updateListOfUsernameAnswers(
        widget.doc, context, widget.username, widget.choice);
    FirebaseCrud().updateListOfUsernamesThatGaveAnswers(
        widget.doc, context, widget.username);
    widget.snapi.removeAt(widget.index);
    widget.snapi.insert(widget.index, QuestionSkelet());
    widget.notifyParent();
    isTapped = false;
  }
}
