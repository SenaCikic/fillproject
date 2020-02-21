import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:fillproject/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyYesNoChoice extends StatefulWidget {
  final String choice, username;
  final int index, target;
  final Function() notifyParent;
  final List<dynamic> snapi;
  final DocumentSnapshot doc;

  MyYesNoChoice(
      {this.choice,
      this.index,
      this.snapi,
      @required this.notifyParent,
      this.target,
      this.doc,
      this.username});

  @override
  _MyYesNoChoiceState createState() => _MyYesNoChoiceState();
}

class _MyYesNoChoiceState extends State<MyYesNoChoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(115.0),
        height: ScreenUtil.instance.setHeight(59.0),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 22.0),
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
    FirebaseCrud().updateListOfUsernames(widget.doc, context, widget.username, widget.choice);


    widget.snapi.removeAt(widget.index);
    widget.notifyParent();

 
      isTapped=false;
  
  }
}
