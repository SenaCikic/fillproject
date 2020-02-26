import 'package:fillproject/components/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyQuestion extends StatelessWidget {
  final String question;
  MyQuestion({this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(245.0),
        height: ScreenUtil.instance.setHeight(70.0),
        child: Text(question,
            style: TextStyle(
                color: MyColor().white,
                fontWeight: FontWeight.w400,
                fontFamily: "LoewNextArabic",
                fontStyle: FontStyle.normal,
                fontSize: ScreenUtil.instance.setSp(22.0))));
  }
}
