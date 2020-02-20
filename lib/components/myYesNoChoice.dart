import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyYesNoChoice extends StatefulWidget {
  final String choice;
  MyYesNoChoice({this.choice});

  @override
  _MyYesNoChoiceState createState() => _MyYesNoChoiceState(choice: choice);
}

class _MyYesNoChoiceState extends State<MyYesNoChoice> {
  final String choice;
  _MyYesNoChoiceState({this.choice});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(115.0),
        height: ScreenUtil.instance.setHeight(59.0),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 22.0),
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
