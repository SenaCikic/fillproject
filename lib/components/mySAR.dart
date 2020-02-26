import 'package:fillproject/components/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySAR extends StatefulWidget {
  final String text;
  MySAR({this.text});

  @override
  _MySARState createState() => _MySARState();
}



class _MySARState extends State<MySAR> {
  @override
void initState() { 
  super.initState();
  setState(() {
    
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 5.0),
        width: ScreenUtil.instance.setWidth(92),
        child: Text(widget.text,
            style: TextStyle(
                color: MyColor().black,
                fontWeight: FontWeight.w700,
                fontFamily: "LoewNextArabic",
                fontStyle: FontStyle.normal,
                fontSize: ScreenUtil.instance.setSp(40.0)),
            textAlign: TextAlign.center));
  }
}
