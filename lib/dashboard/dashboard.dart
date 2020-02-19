import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myCardMCQ.dart';
import 'package:fillproject/components/myCashBalance.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/mySAR.dart';
import 'package:fillproject/firebaseMethods/firebaseCheck.dart';
import 'package:fillproject/models/questionModel.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:flutter/material.dart';

bool visible = false;

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

  String name = '';
  int sar;
  String question;
  List<dynamic> choices;
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
      body: Center(
        child: Column(
          children: <Widget>[
            MyCashBalance(text: 'Your cash\tbalance'),
            MySAR(text: ' 5\tSAR'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 500,
                    child: FutureBuilder(
                      future: FirebaseCheck().getQuestions(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
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
                              print('AAAAAAAAAAAAAAAA $choices');
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    snapi.removeAt(index);
                                  });
                                },
                                child:
                                    new MyCardMCQ(sar: sar, question: question, choices: choices),
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
