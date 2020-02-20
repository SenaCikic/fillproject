import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/emptyCont.dart';
import 'package:fillproject/components/myCardMCQ.dart';
import 'package:fillproject/components/myCashBalance.dart';
import 'package:fillproject/components/mySAR.dart';
import 'package:fillproject/firebaseMethods/firebaseCheck.dart';
import 'package:fillproject/models/questionModel.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

bool visible = false;
DocumentSnapshot snap;
String id;
int userLevel;

class DashboardPage extends StatefulWidget {
  final PasswordArguments arguments;

  DashboardPage({this.arguments});

  @override
  _DashboardPageState createState() =>
      _DashboardPageState(arguments: arguments);
}

class _DashboardPageState extends State<DashboardPage> {
  final PasswordArguments arguments;
  bool isLoggedIn = false;

  int sar, userLevel;
  String id, question;
  List<dynamic> choices;
  List<dynamic> snapi = [];

  _DashboardPageState({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Center(
          child: Column(
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
                        future: Future.delayed(Duration(milliseconds: 500)).then((value) => FirebaseCheck().getQuestions(userLevel)),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            print(userLevel);

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
                                choices = snapi[index].choices;
                                sar = snapi[index].sar;
                                question = snapi[index].title;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      snapi.removeAt(index);
                                    });
                                  },
                                  child: new MyCardMCQ(
                                      sar: sar,
                                      question: question,
                                      choices: choices),
                                );
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.speaker_notes),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.view_carousel),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text(''))
        ],
      ),
    );
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
