import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/emptyCont.dart';
import 'package:fillproject/components/myCardMCQ.dart';
import 'package:fillproject/components/myCardYesNo.dart';
import 'package:fillproject/components/myCashBalance.dart';
import 'package:fillproject/components/mySAR.dart';
import 'package:fillproject/firebaseMethods/firebaseCheck.dart';
import 'package:fillproject/models/Question/questionModel.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

bool visible = false;
DocumentSnapshot snap;
String id;
int userLevel;

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
  var io;
  int sar, target;
  String question, type, username;
  List<dynamic> choices;
  List<dynamic> snapi = [];
  List<dynamic> usernameThatAnswers;
  DocumentSnapshot doc;
  ValueKey key;

  _DashboardPageState({this.arguments});

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    visible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: _onWillPop,
      child: Center(
        child: ListView(
          children: <Widget>[
            /// [getUsername] - pomocu ove metode uzimamo sve itne odatke od usera
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
                        id = snap.data['user_id'];
                        userLevel = snap.data['level'];
                        username = snap.data['username'];
                        print('User je: ' +
                            id +
                            " , a level je = " +
                            userLevel.toString());
                        return EmptyContainer();
                      });
                }
                return EmptyContainer();
              },
            ),

            MyCashBalance(text: 'Your cash\tbalance'),
            MySAR(text: ' 5\tSAR'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 500,
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
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
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
                              if (snapi[index].title != '') {
                                if (usernameThatAnswers.contains(username) ==
                                    false && target>0) {
                                  return type == 'checkbox'
                                      ? new MyCardMCQ(
                                          key: key,
                                          sar: sar,
                                          question: question,
                                          choices: choices,
                                          snapi: snapi,
                                          index: index,
                                          notifyParent: refresh,
                                          target: target,
                                          doc: doc,
                                          username: username,
                                        )
                                      : MyCardYesNo(
                                          key: key,
                                          sar: sar,
                                          question: question,
                                          snapi: snapi,
                                          index: index,
                                          notifyParent: refresh,
                                          target: target,
                                          doc: doc,
                                          username: username);
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
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the app?'),
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
}
