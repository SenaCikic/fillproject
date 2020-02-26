import 'dart:async';
import 'dart:io';
import 'package:fillproject/components/emptyCont.dart';
import 'package:fillproject/components/myColor.dart';
import 'package:fillproject/components/mySnackbar.dart';
import 'package:fillproject/components/myText.dart';
import 'package:fillproject/components/myTextComponent.dart';
import 'package:fillproject/components/myValidation.dart';
import 'package:fillproject/firebaseMethods/firebaseCheck.dart';
import 'package:fillproject/home/homePage.dart';
import 'package:fillproject/localStorage/loginStorage.dart';
import 'package:fillproject/routes/routeArguments.dart';
import 'package:fillproject/routes/routeConstants.dart';
import 'package:fillproject/utils/screenUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/myColor.dart';

class RegisterPage extends StatefulWidget {
  final DidntRecievePinArguments arguments;
  RegisterPage({this.arguments});

  @override
  _RegisterPageState createState() => _RegisterPageState(arguments: arguments);
}

class _RegisterPageState extends State<RegisterPage> {
  String phoneNo, smsCode, verificationId, username, name;
  String usernameInit, phoneInit;
  SharedPreferences prefs;

  final DidntRecievePinArguments arguments;
  _RegisterPageState({this.arguments});

  populateReg() async  {
      prefs = await SharedPreferences.getInstance();
    usernameInit = prefs.getString('usernameReg');
    phoneInit = prefs.getString('phoneReg');
    usernameController.text = usernameInit;
    phoneController.text = phoneInit;  
    }

  @override
  void initState() {
    populateReg();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoggedIn = false, brPostoji = false, usernamePostoji = false;

  TextEditingController phoneController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Constant().responsive(context);

    Future<void> verifyPhone() async {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        this.verificationId = verId;
      };

      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        Navigator.of(context).pushNamed(VerifyPin,
            arguments: RegisterArguments(
                verId: verificationId,
                username: usernameController.text,
                phone: phoneController.text));
      };

      final PhoneVerificationCompleted verificationSuccess =
          (AuthCredential user) {};

      final PhoneVerificationFailed verificationFailed =
          (AuthException exception) {
        print('${exception.message}');
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationSuccess,
          verificationFailed: verificationFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: autoRetrieve);
    }

    onFieldSubmitted1(BuildContext context) {
      phoneNo = "+" + phoneController.text;
      final _formState = _formKey.currentState;
      if (_formState.validate()) {
        LoginStorage().loginUser(username, isLoggedIn);
        verifyPhone();
      }
    }

    return Scaffold(
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
      backgroundColor: MyColor().black,
      body: Builder(
        builder: (context) => new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child:
                              MyTextComponent(text: MyText().registerHeadline),
                        )),
                        Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 61.0, bottom: 59),
                          child: Text(
                            MyText().registerSubtitle,
                            style: TextStyle(
                                color: MyColor().white,
                                fontSize: ScreenUtil.instance.setSp(40)),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        Container(
                          width: ScreenUtil.instance.setWidth(316.0),
                          height: ScreenUtil.instance.setHeight(92.0),
                          margin:
                              EdgeInsets.only(bottom: 19, left: 49, right: 49),
                          child: TextFormField(
                            enableSuggestions: false,
                            textCapitalization: TextCapitalization.sentences,
                            controller: usernameController,
                            decoration: InputDecoration(
                              //  floatingLabelBehavior: FloatingLabelBehavior.never,
                              hasFloatingPlaceholder: false,
                              errorStyle: TextStyle(
                                  inherit: true,
                                  textBaseline: TextBaseline.ideographic),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 35.0),
                              labelText: MyText().labelUsername,
                              labelStyle: TextStyle(
                                  color: MyColor().white, fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(color: MyColor().white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(color: MyColor().white),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(
                                  color: MyColor().error,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(
                                  color: MyColor().error,
                                ),
                              ),
                            ),
                            style: TextStyle(color: MyColor().white),
                            validator: (username) => MyValidation()
                                .validateUsername(username, usernamePostoji),
                            onChanged: (input) {
                              setState(() {
                                username = input;
                              });
                            },
                            onFieldSubmitted: (value) async {
                              try {
                                final result =
                                    await InternetAddress.lookup('google.com');
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {
                                  onFieldSubmitted1(context);
                                  //Navigator.of(context).pushNamed(VerifyPin);
                                }
                              } on SocketException catch (_) {
                                MySnackbar().showSnackbar(
                                    MyText().checkConnection,
                                    context,
                                    MyText().snackUndo);
                              }
                            },
                          ),
                        ),
                        Container(
                          width: ScreenUtil.instance.setWidth(316.0),
                          height: ScreenUtil.instance.setHeight(92.0),
                          margin: EdgeInsets.only(left: 49, right: 49),
                          child: TextFormField(
                            enableSuggestions: false,
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                            decoration: InputDecoration(
                              hasFloatingPlaceholder: false,
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 35.0),
                              prefix: Text(
                                "+966",
                                style: TextStyle(color: MyColor().white),
                              ),
                              labelText: MyText().labelPhone,
                              labelStyle: TextStyle(color: MyColor().white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(color: MyColor().white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(color: MyColor().white),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(
                                  color: MyColor().error,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33.5)),
                                borderSide: BorderSide(
                                  color: MyColor().error,
                                ),
                              ),
                            ),
                            onChanged: (input) {
                              setState(() {
                                phoneNo = input;
                              });
                            },
                            validator: (phone) =>
                                MyValidation().validatePhone(phone, brPostoji),
                            onFieldSubmitted: (value) async {
                              try {
                                final result =
                                    await InternetAddress.lookup('google.com');
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {
                                  onFieldSubmitted1(context);
                                  //Navigator.of(context).pushNamed(VerifyPin);
                                }
                              } on SocketException catch (_) {
                                MySnackbar().showSnackbar(
                                    MyText().checkConnection,
                                    context,
                                    MyText().snackUndo);
                              }
                            },
                            style: TextStyle(color: MyColor().white),
                          ),
                        ),

                        Container(
                            width: ScreenUtil.instance.setWidth(316.0),
                            height: ScreenUtil.instance.setHeight(67.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(33.5),
                              ),
                              onPressed: () async {
                                prefs.setString('usernameReg', usernameController.text);
                                prefs.setString('phoneReg', phoneController.text);
                                try {
                                  final result = await InternetAddress.lookup(
                                      'google.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    onFieldSubmitted1(context);
                                    //Navigator.of(context).pushNamed(VerifyPin);
                                    print("TU SAM");
                                  }
                                } on SocketException catch (_) {
                                  MySnackbar().showSnackbar(
                                      MyText().checkConnection,
                                      context,
                                      MyText().snackUndo);
                                  print("ERROR");
                                }
                              },
                              child: Text("Send PIN",
                                  style: TextStyle(fontSize: 18)),
                            )),

                        /// PROVJERA DA LI POSTOJI USERNAME ILI NUMBER
                        Column(
                          children: <Widget>[
                            FutureBuilder(
                              future: FirebaseCheck()
                                  .doesNumberAlreadyExist(phoneNo),
                              builder: (context, AsyncSnapshot<bool> result) {
                                if (!result.hasData) {
                                  return EmptyContainer();
                                }
                                if (result.data) {
                                  brPostoji = true;
                                  return EmptyContainer();
                                } else {
                                  brPostoji = false;
                                  return EmptyContainer();
                                }
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            FutureBuilder(
                              future: FirebaseCheck()
                                  .doesNameAlreadyExist(username),
                              builder: (context, AsyncSnapshot<bool> result) {
                                if (!result.hasData) {
                                  return EmptyContainer();
                                }
                                if (result.data) {
                                  usernamePostoji = true;
                                  return EmptyContainer();
                                } else {
                                  usernamePostoji = false;
                                  return EmptyContainer();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignUp()));
    return EmptyContainer() ?? true;
  }
}
