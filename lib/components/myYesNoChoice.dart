import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myInternetCheck.dart';
import 'package:fillproject/components/mySnackbar.dart';
import 'package:fillproject/components/myText.dart';
import 'package:fillproject/firebaseMethods/firebaseCrud.dart';
import 'package:fillproject/globals.dart';
import 'package:fillproject/models/Question/questionSkelet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyYesNoChoice extends StatefulWidget {
  final String choice, username;
  final int index, target,  sar;
  final Function() notifyParent;
  final List<dynamic> snapi;
  final DocumentSnapshot doc, snap;
  final ValueKey key;
  int usersSars;

  MyYesNoChoice(
      {this.choice,
      this.snap,
      this.usersSars,
      this.key,
      this.sar,
      this.index,
      this.snapi,
      @required this.notifyParent,
      this.target,
      this.doc,
      this.username});

  @override
  _MyYesNoChoiceState createState() => _MyYesNoChoiceState();
}

class _MyYesNoChoiceState extends State<MyYesNoChoice> {
  static const Duration DEFAULT_TIMEOUT = Duration(seconds: 20);
  static const int DEFAULT_PORT = 53;

  static final List<AddressCheckOptions> defaultAddresses = List.unmodifiable([
    AddressCheckOptions(
      InternetAddress('1.1.1.1'),
      port: DEFAULT_PORT,
      timeout: DEFAULT_TIMEOUT,
    ),
    AddressCheckOptions(
      InternetAddress('8.8.4.4'),
      port: DEFAULT_PORT,
      timeout: DEFAULT_TIMEOUT,
    ),
    AddressCheckOptions(
      InternetAddress('208.67.222.222'),
      port: DEFAULT_PORT,
      timeout: DEFAULT_TIMEOUT,
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
        key: widget.key,
        width: ScreenUtil.instance.setWidth(115.0),
        height: ScreenUtil.instance.setHeight(53.0),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 22.0, top: 50),
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
            onPressed: () async {
              setState(() {
                  isTapped = true;
                });
              MyInternetCheck().connection.addresses = MyInternetCheck().defaultAddresses;
              if (await MyInternetCheck().connection.hasConnection) {
                Timer(Duration(milliseconds: 50), () {
                  onPressed();
                });
              } else {
                onPressed();
                MySnackbar().showSnackbar(
                    MyText().checkConnection, context, MyText().snackUndo);
              }
            },
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
    int counter = widget.target - 1;
     widget.usersSars += widget.sar;
     saroviOffline += widget.sar;
    // int addSar = widget.usersSars + widget.sar;
    FirebaseCrud().updateTarget(widget.doc, context, counter);
    FirebaseCrud().updateUsersSars(widget.snap, context, saroviOffline);
    FirebaseCrud().updateListOfUsernameAnswers(
        widget.doc, context, widget.username, widget.choice);
    FirebaseCrud().updateListOfUsernamesThatGaveAnswers(
        widget.doc, context, widget.username);
    widget.snapi.removeAt(widget.index);
    widget.snapi.insert(widget.index, QuestionSkelet());
    widget.notifyParent();

    isTapped = false;
  }
}
