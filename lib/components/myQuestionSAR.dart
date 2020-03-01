import 'package:fillproject/components/constants/fontsConstants.dart';
import 'package:fillproject/components/constants/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyQuestionSAR extends StatelessWidget {
  final String text;
  MyQuestionSAR({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.instance.setWidth(121.0),
      height: ScreenUtil.instance.setHeight(38.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: MyColor().white),
      child: Text(text,
          style: TextStyle(
              color: MyColor().black,
              fontWeight: FontWeight.w700,
              fontFamily: arabic,
              fontStyle: FontStyle.normal,
              fontSize: ScreenUtil.instance.setSp(22.0)),
          textAlign: TextAlign.center),
    );
  }
}
