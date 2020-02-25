import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myInternetCheck.dart';
import 'package:fillproject/components/mySnackbar.dart';
import 'package:fillproject/components/myText.dart';
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

  MyMCQChoice({
    this.choice,
    this.snapi,
    this.index,
    this.notifyParent,
    this.target,
    this.doc,
    this.username,
    this.sar,
    this.snap,
    this.usersSar,
  });

  @override
  _MyMCQChoiceState createState() => _MyMCQChoiceState();
}

class _MyMCQChoiceState extends State<MyMCQChoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(257.0),
        height: ScreenUtil.instance.setHeight(53.0),
        margin: EdgeInsets.only(bottom: 26.0),
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
              MyInternetCheck().connection.addresses =
                  MyInternetCheck().defaultAddresses;
              if (await MyInternetCheck().connection.hasConnection) {
                Timer(Duration(milliseconds: 50), () {
                  onPressed();
                });
              } else {
                onPressed();
                MySnackbar().showSnackbar(
                    MyText().checkConnection, context, MyText().snackUndo);
              }
            },
            child: Text(widget.choice,
                style: TextStyle(
                    color: isTapped ? MyColor().black : MyColor().white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "LoewNextArabic",
                    fontStyle: FontStyle.normal,
                    fontSize: ScreenUtil.instance.setSp(18.0))),
          ),
        ),
        decoration: BoxDecoration(
            color: isTapped ? MyColor().white : MyColor().black,
            border: Border.all(color: MyColor().white),
            borderRadius: BorderRadius.all(Radius.circular(33.5))));
  }

  onPressed() {
    int counter = widget.target - 1;
    int addSar = widget.usersSar + widget.sar;
    FirebaseCrud().updateTarget(widget.doc, context, counter);
    FirebaseCrud().updateUsersSars(widget.snap, context, addSar);
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
