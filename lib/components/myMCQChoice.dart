import 'package:fillproject/components/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../globals.dart';

class MyMCQChoice extends StatefulWidget {
  final String choice;
  MyMCQChoice({this.choice});

  @override
  _MyMCQChoiceState createState() => _MyMCQChoiceState(choice: choice);
}

class _MyMCQChoiceState extends State<MyMCQChoice> {
  final String choice;
  _MyMCQChoiceState({this.choice});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(257.0),
        height: ScreenUtil.instance.setHeight(53.0),
        margin: EdgeInsets.only(bottom: 26.0),
        alignment: Alignment.center,
        child: RaisedButton(
          hoverColor: isTapped ? MyColor().white : MyColor().black,
          elevation: 0,
          color: isTapped ? MyColor().white : MyColor().black,
          onPressed: () {
            setState(() {
              isTapped = !isTapped;
              print(isTapped);
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
        decoration: BoxDecoration(
            color: isTapped ? MyColor().white : MyColor().black,
            border: Border.all(color: MyColor().white),
            borderRadius: BorderRadius.all(Radius.circular(33.5))));
  }
}
