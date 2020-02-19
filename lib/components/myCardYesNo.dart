import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myQuestion.dart';
import 'package:fillproject/components/myQuestionSAR.dart';
import 'package:fillproject/components/myYesNoChoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCardYesNo extends StatelessWidget {
  final String text;
  MyCardYesNo({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(336.0),
        height: ScreenUtil.instance.setHeight(320.0),
        margin: EdgeInsets.only(bottom: 29.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: MyColor().black),
        child: Stack(children: <Widget>[
          PositionedDirectional(
              top: 98,
              start: 49,
              child: MyQuestion(
                question:
                    'This part is for questionsThis part is for questionsThis ?',
              )),
          PositionedDirectional(
              top: 41, start: 41, child: MyQuestionSAR(text: '50 SAR')),
          PositionedDirectional(
              top: 200,
              start: 41,
              child: Row(
                children: <Widget>[
                  MyYesNoChoice(choice: 'Yes'),
                  MyYesNoChoice(choice: 'No')
                ],
              ))
        ]));
  }
}
