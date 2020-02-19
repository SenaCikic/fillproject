import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myMCQChoice.dart';
import 'package:fillproject/components/myQuestion.dart';
import 'package:fillproject/components/myQuestionSAR.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCardMCQ extends StatelessWidget {
  final String question;
  final int sar;
  final List<String> choices = ['jedan', 'dva', 'tri'];

  MyCardMCQ({this.sar, this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(336.0),
        height: ScreenUtil.instance.setHeight(490.0),
        margin: EdgeInsets.only(bottom: 29.0, right: 15, left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: MyColor().black),
        child: Stack(children: <Widget>[
          PositionedDirectional(
              top: 98,
              start: 49,
              child: MyQuestion(
                question: question,
              )),
          PositionedDirectional(
              top: 41, start: 41, child: MyQuestionSAR(text: '$sar SAR')),
          PositionedDirectional(
              top: 180,
              start: 41,
              child: Container(
                height: ScreenUtil.instance.setHeight(200.0),
                width: ScreenUtil.instance.setWidth(260.0),
                                child: ListView(
                    children: choices
                        .map((item) => MyMCQChoice(choice: item))
                        .toList()),
              ))
        ]));
  }
}
