import 'package:fillproject/components/MySAR.dart';
import 'package:fillproject/components/myCardMCQ.dart';
import 'package:fillproject/components/myCashBalance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/firebaseMethods/firebaseCheck.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/models/questionModel.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  bool visible = false;
  String name = '';
  int sar;
  String question;
  List<dynamic> choices;
  List<dynamic> choicesEnd;
  List<dynamic> snapi = [];

  @override
  void initState() {
    super.initState();
    FirebaseCheck().getQuestions();
  }

  _DashboardPageState({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().black,
      appBar: new AppBar(
        title: new Text(MyText().appBarDash),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 400,
                  child: FutureBuilder(
                    future: FirebaseCheck().getQuestions(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        snapi = snapshot.data
                            .map((doc) => Question.fromDocument(doc))
                            .toList();

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapi.length,
                          itemBuilder: (BuildContext context, int index) {
                            // question = snapshot.data[index].data['title'];
                            // sar = snapshot.data[index].data['sar'];
                            //  choices = snapi[index].choices;
                            // List<dynamic> choiseOne = [];
                            // for (int i = 0; i < choices.length; i++) {
                            //   choiseOne.add(choices[i]['text']);
                            // }
                            return new Column(
                              key: UniqueKey(),
                              children: <Widget>[
                                new Text('Sar ' + snapi[index].sar.toString(),
                                    style: TextStyle(color: MyColor().white)),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(snapi[index].title + " ",
                                    style: TextStyle(color: MyColor().white)),
                                SizedBox(
                                  height: 15.0,
                                ),
                                // new Column(
                                //   children: choiseOne
                                //       .map((item) => Container(
                                //             child: Text(item,
                                //                 style: TextStyle(
                                //                     color: MyColor().white)),
                                //           ))
                                //       .toList(),
                                // ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                new OutlineButton(
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      style: BorderStyle.solid,
                                      width: 3.0),
                                  child: Text(MyText().btnLogout,
                                      style: TextStyle(color: MyColor().white)),
                                  onPressed: () {
                                    setState(() {
                                      snapi.removeAt(index);
                                    });

                                    print(
                                        'u deletu sam ali necu da obrisem hehe');
                                  },
                                ),
                              ],
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

  onPressed(BuildContext context, int index) {
    setState(() {
      snapi.removeAt(index);
    });
  }
}
