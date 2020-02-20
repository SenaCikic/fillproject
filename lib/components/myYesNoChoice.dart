import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyYesNoChoice extends StatefulWidget {
  final String choice;
  final int index;
  final Function() notifyParent;
  final List<dynamic> snapi;
  MyYesNoChoice({this.choice, this.index, this.snapi, @required this.notifyParent});

  @override
  _MyYesNoChoiceState createState() => _MyYesNoChoiceState(choice: choice, snapi: snapi, index: index,notifyParent: notifyParent );
}

class _MyYesNoChoiceState extends State<MyYesNoChoice> {
  final String choice;
  final int index;
  final List<dynamic> snapi;
  final Function() notifyParent;
  _MyYesNoChoiceState({this.choice, this.index, this.snapi, @required this.notifyParent});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(115.0),
        height: ScreenUtil.instance.setHeight(59.0),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 22.0),
        child: Container(
           width: ScreenUtil.instance.setWidth(257.0),
          height: ScreenUtil.instance.setHeight(53.0),
          child: RaisedButton(
             shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(28.0),
            ),
            hoverColor: isTapped ? MyColor().white : MyColor().black,
            elevation: 0,
            color: isTapped ? MyColor().white : MyColor().black,
            onPressed: () => onPressed(),
            child: Text(widget.choice,
                style: TextStyle(
                    color: isTapped ? MyColor().black : MyColor().white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "LoewNextArabic",
                    fontStyle: FontStyle.normal,
                    fontSize: ScreenUtil.instance.setSp(18.0))),
          ),
        ),
        decoration: BoxDecoration(
            color: isTapped ? MyColor().white : MyColor().black,
            border: Border.all(color: MyColor().white),
            borderRadius: BorderRadius.all(Radius.circular(33.5))));
  }
  
 onPressed() {
    snapi.removeAt(index);
    widget.notifyParent();
    setState(() {
       isTapped = !isTapped;
    });
  }
}
