import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/customScroll.dart';
import 'package:fillproject/components/emptyCont.dart';
import 'package:fillproject/components/myCardMCQ.dart';
import 'package:fillproject/components/myCardYesNo.dart';
import 'package:fillproject/components/myCashBalance.dart';
import 'package:fillproject/components/mySAR.dart';
import 'package:fillproject/components/myText.dart';
import 'package:fillproject/firebaseMethods/firebaseCheck.dart';
import 'package:fillproject/globals.dart';
import 'package:fillproject/models/Question/questionModel.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

bool visible = false;
DocumentSnapshot snap;
String id;
int userLevel;
bool isEmptyCard = false;

class DashboardPage extends StatefulWidget {
  final PasswordArguments arguments;

  DashboardPage({Key key, this.arguments}) : super(key: key);

  @override
  _DashboardPageState createState() =>
      _DashboardPageState(arguments: arguments);
}

class _DashboardPageState extends State<DashboardPage> {
  final PasswordArguments arguments;
  bool isLoggedIn = false;
  bool isSar = false;
  int counter = 0;
  int sar, target, userSar = 0;
  String question, type, username;
  List<dynamic> choices;
  List<dynamic> snapi = [];
  List<dynamic> usernameThatAnswers;
  DocumentSnapshot doc;
  ValueKey key;

  ScrollController _controller = new ScrollController();
  ScrollPhysics _physics;

  // List<dynamic> questions = List.generate(snapi.length, (index) => index);

  _DashboardPageState({this.arguments});

  @override
  void initState() {
    super.initState();
    visible = false;
    Timer(Duration(milliseconds: 500), () {
      setState(() {});
    });
    _controller.addListener(() {
         if(_controller.position.haveDimensions && _physics == null) {
               setState(() {
                   var dimension = _controller.position.maxScrollExtent / (snapi.length - 1);
                   _physics = CustomScrollPhysics(itemDimension: dimension);
               });
         }
    });
  }

  refresh() {
    setState(() {});
    Timer(Duration(milliseconds: 500), () {
      setState(() {

      });
    });
    checkForInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: _onWillPop,
      child: Center(
        child: ListView(
          children: <Widget>[
            /// [getUsername] - pomocu ove metode uzimamo sve bitne odatke od usera
            ///
            /// userID [id] i userov level [userLevel]
            FutureBuilder(
              future: FirebaseCheck().getUserUsername(arguments.username),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        snap = snapshot.data[index];
                        userSar = snap.data['sar'];
                        if (counter == 0) {
                          saroviOffline = userSar;
                          counter = 1;
                        }
                        id = snap.data['user_id'];
                        userLevel = snap.data['level'];
                        username = snap.data['username'];
                        return EmptyContainer();
                      });
                }
                return EmptyContainer();
              },
            ),
            MyCashBalance(text: MyText().sarText),

            MySAR(text: isSar ? saroviOffline.toString() : '$userSar\nSAR'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: ScreenUtil.instance.setHeight(475.0),
                    child: FutureBuilder(
                      future: Future.delayed(Duration(milliseconds: 500)).then(
                          (value) => FirebaseCheck().getQuestions(userLevel)),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          /// punjenje lokalnog niza
                          ///
                          /// nakon sto se jednom napuni nepuni se vise
                          /// visible se seta na true
                          if (!visible) {
                            snapi = snapshot.data
                              .map((doc) => Question.fromDocument(doc))
                              .toList();
                            visible = true;
                          }

                          return ListView.builder(
                            controller: _controller,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: _physics,
                            itemCount: snapi.length,
                            itemBuilder: (BuildContext context, int index) {
                              doc = snapshot.data[index];
                              choices = snapi[index].choices;
                              key = snapi[index].key;
                              sar = snapi[index].sar;
                              question = snapi[index].title;
                              type = snapi[index].type;
                              target = snapi[index].target;
                              usernameThatAnswers =
                                  snapi[index].listOfUsernamesThatGaveAnswers;
                                if(snapi[index].title == '') {
                                  isEmptyCard = true;
                                }
                              if (snapi[index].title != '') {
                                isEmptyCard = false;
                                if (usernameThatAnswers.contains(username) ==
                                        false &&
                                    target > 0) {
                                  return type == 'checkbox'
                                      ? (isEmptyCard ? EmptyContainer() :                                      
                                      MyCardMCQ(
                                        key: key,
                                        sar: sar,
                                        isSar: isSar,
                                        usersSar: userSar,
                                        question: question,
                                        choices: choices,
                                        snapi: snapi,
                                        snap: snap,
                                        index: index,
                                        notifyParent: refresh,
                                        target: target,
                                        doc: doc,
                                        username: username,
                                      ))
                                      : (isEmptyCard ? EmptyContainer() :
                                      MyCardYesNo(
                                          key: key,
                                          sar: sar,
                                          isSar: isSar,
                                          usersSar: userSar,
                                          snap: snap,
                                          question: question,
                                          snapi: snapi,
                                          index: index,
                                          notifyParent: refresh,
                                          target: target,
                                          doc: doc,
                                          username: username));
                                } else {
                                  return EmptyContainer();
                                }
                              } else {
                                return EmptyContainer();
                              }
                            }, 
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Future<bool> _onWillPop() async {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(MyText().willQuestion),
            content: new Text(MyText().willQuestion1),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        true;
  }

  checkForInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isSar = false;
      }
    } on SocketException catch (_) {
      isSar = true;
    }
  }
}
