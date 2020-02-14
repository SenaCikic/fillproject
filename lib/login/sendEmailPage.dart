import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/myText.dart';
import 'package:flutter/material.dart';

class EmailResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor().black,
        appBar: new AppBar(
          title: new Text(""),
          backgroundColor: MyColor().black,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: // Rectangle
            Container(
                width: 414,
                height: 896,
                decoration: BoxDecoration(color: const Color(0xff000000)),
                child: Stack(children: [
                  // Fill In form
                  PositionedDirectional(
                    top: 370,
                    start: 54,
                    child: SizedBox(
                        width: 316,
                        height: 67,
                        child: // Group
                            SizedBox(
                                width: 316,
                                height: 67,
                                child: Stack(children: [
                                  // Rectangle Copy
                                  PositionedDirectional(
                                    top: 0,
                                    start: 0,
                                    child: Container(
                                        width: 316,
                                        height: 67,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(33.5)),
                                            border: Border.all(
                                                color: const Color(0xffffffff),
                                                width: 2))),
                                  ),
                                  // Passward
                                  PositionedDirectional(
                                    top: 22,
                                    start: 51,
                                    child: SizedBox(
                                        width: 52,
                                        height: 23,
                                        child: Text(MyText().emailPlace,
                                            style: const TextStyle(
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "LoewNextArabic",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 18.0),
                                            textAlign: TextAlign.center)),
                                  )
                                ]))),
                  ),
                  // Reset passward
                  PositionedDirectional(
                    top: 91,
                    start: 120.5,
                    child: SizedBox(
                        width: 184,
                        height: 28,
                        child: Text( MyText().resetHead,
                            style: const TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                fontFamily: "LoewNextArabic",
                                fontStyle: FontStyle.normal,
                                fontSize: 23.0),
                            textAlign: TextAlign.center)),
                  ),
                  // Rectangle Copy 2
                  PositionedDirectional(
                    top: 459,
                    start: 46,
                    child: Container(
                        width: 316,
                        height: 67,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(33.5)),
                            color: const Color(0xffffffff))),
                  ),
                  // Submit
                  PositionedDirectional(
                    top: 481,
                    start: 170,
                    child: SizedBox(
                        width: 68,
                        height: 23,
                        child: Text(MyText().btnSubmit,
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                fontFamily: "LoewNextArabic",
                                fontStyle: FontStyle.normal,
                                fontSize: 18.0),
                            textAlign: TextAlign.center)),
                  ),
                  // If you do not know y
                  PositionedDirectional(
                    top: 141,
                    start: 72,
                    child: SizedBox(
                        width: 269,
                        height: 66,
                        child: Text(
                                 MyText().ifYouDont,
                            style: const TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w500,
                                fontFamily: "LoewNextArabic",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.center)),
                  )
                ])));
  }
}
