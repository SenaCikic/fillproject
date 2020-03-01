
import 'package:fillproject/components/constants/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCashBalance extends StatelessWidget {
  final String text;
  MyCashBalance({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40.0, bottom: 5.0),
        width: ScreenUtil.instance.setWidth(120),
        child: Text(text,
            style: TextStyle(
                color: MyColor().black,
                fontWeight: FontWeight.w700,
                fontFamily: "LoewNextArabic",
                fontStyle: FontStyle.normal,
                fontSize: ScreenUtil.instance.setSp(23.0)),
            textAlign: TextAlign.center));
  }
}
