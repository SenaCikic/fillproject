import 'package:fillproject/components/constants/fontsConstants.dart';
import 'package:fillproject/components/constants/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextComponent extends StatelessWidget {
  final String text;
  MyTextComponent({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: MyColor().white,
        fontWeight: FontWeight.w700,
        fontFamily: arabic,
        fontStyle: FontStyle.normal,
        fontSize: ScreenUtil.instance.setSp(23.0),
      ),
      textAlign: TextAlign.center,
    );
  }
}
