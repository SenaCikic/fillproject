import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/emptyCont.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/dashboard/dashboard.dart';
import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../globals.dart';

class MyMCQChoice extends StatefulWidget {
  final DocumentSnapshot doc;
  final String choice;
  final int index, target;
  final Function() notifyParent;
  final List<dynamic> snapi;
  MyMCQChoice(
      {this.choice,
      this.snapi,
      this.index,
      this.notifyParent,
      this.target,
      this.doc});

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
            onPressed: () {
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
    FirebaseCrud().updateTarget(widget.doc, context, counter);

    widget.snapi.removeAt(widget.index);
    widget.notifyParent();

    isTapped = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
