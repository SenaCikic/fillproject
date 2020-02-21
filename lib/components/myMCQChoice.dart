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
  MyMCQChoice({this.choice, this.snapi, this.index, this.notifyParent, this.target, this.doc});

  @override
  _MyMCQChoiceState createState() => _MyMCQChoiceState(
      choice: choice, snapi: snapi, index: index, notifyParent: notifyParent, target: target, doc: doc);
}

class _MyMCQChoiceState extends State<MyMCQChoice> {
  final DocumentSnapshot doc;
  final String choice;
  final int index, target;
  final List<dynamic> snapi;
  final Function() notifyParent;
  var o;
  _MyMCQChoiceState(
      {this.choice, this.index, this.snapi, @required this.notifyParent, this.target, this.doc});

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
            onPressed: () => onPressed(),
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
    snapi.removeAt(index);
    widget.notifyParent();

    int counter = target -1;
    FirebaseCrud().updateTarget(doc, context, counter);

    setState(() {
      isTapped = !isTapped;
    });
  }
}
