import 'package:fillproject/components/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyMCQChoice extends StatelessWidget {
  final String choice;
  MyMCQChoice({this.choice});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(257.0),
        height: ScreenUtil.instance.setHeight(53.0),
        margin: EdgeInsets.only(bottom: 26.0),
        alignment: Alignment.center,
        child: Text(choice,
            style: TextStyle(
                color: MyColor().white,
                fontWeight: FontWeight.w400,
                fontFamily: "LoewNextArabic",
                fontStyle: FontStyle.normal,
                fontSize: ScreenUtil.instance.setSp(18.0))),
        decoration: BoxDecoration(
            border: Border.all(color: MyColor().white),
            borderRadius: BorderRadius.all(Radius.circular(33.5))));
  }
}
