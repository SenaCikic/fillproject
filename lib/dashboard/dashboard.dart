import 'package:fillproject/components/MyText.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/firebaseMethods/firebaseCheck.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
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
  String name = '';
  int sar;
  String question;
  List<dynamic> choices;
  List<dynamic> choicesEnd;

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
        children: <Widget>[
          FutureBuilder(
            future: FirebaseCheck().getQuestions(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    question = snapshot.data[index].data['title'];
                    sar = snapshot.data[index].data['sar'];
                   choices = snapshot.data[index].data['choices'];
                   List<dynamic> choiseOne = [];
                    for (int i = 0; i < choices.length; i++) {
                      choiseOne.add(choices[i]['text']);
                    }
                    return Container(
                      child: new Column(
                        children: <Widget>[
                          new Text('Sar $sar',
                              style: TextStyle(color: MyColor().white)),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text('Pitanje $question',
                              style: TextStyle(color: MyColor().white)),
                          SizedBox(
                            height: 15.0,
                          ),
                          new Column(
                              children: choiseOne.map((item) => Container(
                                child: Text(item,style: TextStyle(color: MyColor().white)),
                              )).toList(), 
                          ),
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
                            onPressed: () => onPressed(context),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return SizedBox();
            },
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

  onPressed(BuildContext context) {
    FirebaseAuth.instance.signOut().then((action) {
      Navigator.of(context).pushNamed(Home);
    }).catchError((e) {
      print(e);
    });
    LoginStorage().logout(name, isLoggedIn);
  }
}
