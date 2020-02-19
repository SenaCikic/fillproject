import 'package:fillproject/components/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyYesNoChoice extends StatelessWidget {
  final String choice;
  MyYesNoChoice({this.choice});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(115.0),
        height: ScreenUtil.instance.setHeight(59.0),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 22.0),
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
