library expo;

import 'package:application/screens/expo1/ToolsChoosing.dart';
import 'package:application/screens/home/home.dart';
import 'package:application/screens/login/login.dart';
import 'package:application/screens/map/questioneer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';
import 'package:application/screens/Avatar/avatar.dart';
import 'package:application/screens/login/homescreen.dart';
import 'package:application/screens/login/password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'body.dart';
import 'feelings.dart';
import 'thoughts.dart';
import 'dart:ui';
import 'dart:math';
import 'dart:async';

class FeelingsTools extends StatelessWidget {
  FeelingsTools({required this.adata, required this.theCase, required this.prev});
  final AvatarData adata;
  final int prev;
  final String theCase;
  int fear = 0;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ExpoData(
          adata: adata,
          theCase: theCase,
          body_task: 0,
          feelings_task: 0,
          thoughts_task: 0),
      child: MaterialApp(
        title: 'חשיפה 1',
        // Start the app with the "/" named route. In this case, the app starts
        // on the FirstScreen widget.
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => _Page1(prev:prev),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/second': (context) => _Page2(),
          '/main': (context) => _Main(),
          '/thoughts/1': (context) => thought1_1(),
          '/thoughts/2': (context) => thought2_1(),
          '/feelings/1': (context) => feeling1_1(),
          '/body/1': (context) => body1_1(),
          '/tools': (context) => tools(theCase: theCase,adata: adata),
        },
      ),
    );
  }
}

class _Page1 extends StatefulWidget {
  _Page1({required this.prev});
  final int prev;
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<_Page1> {

  double feeling = 0;

  Future<AvatarData>? _adata;
  Future<String>? _name;
  @override
  void initState() {
    super.initState();
    _adata = AvatarData.load();
    _name = _getname();
  }

  Future<String> _getname() async {
    var name = (await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthRepository.instance().user?.uid)
        .get())['name'];
    print(name);
    return name;
  }
  var scaffoldKey = GlobalKey<ScaffoldState>();
  /**/

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(key: scaffoldKey,
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(children: [
                Stack(
                  children: [
                    Positioned(
                        child: Image.asset('images/talky.png'),
                        top: 0,
                        right: 0),
                    Positioned(
                        top: 10,
                        right: 6,
                        child: FutureBuilder<String>(
                          future: _name,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            // ...
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              String data = snapshot.data ?? '';
                              return Text(
                                'היי $data\n מה קורה?',
                                textDirection: TextDirection.rtl,
                                style: GoogleFonts.assistant(),
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        )),
                  ],
                ),
                Positioned(
                    child: FutureBuilder<AvatarData>(
                      future: _adata,
                      builder: (BuildContext context,
                          AsyncSnapshot<AvatarData> snapshot) {
                        // ...
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AvatarStack(
                              data: (snapshot.data ??
                                  AvatarData(body: AvatarData.body_default)));
                        }
                        return CircularProgressIndicator();
                      },
                    )),
              ])),
          ListTile(
            title: Text("עצב דמות",
                textDirection: TextDirection.rtl,
                style: GoogleFonts.assistant()),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Avatar(first: false, data: _adata)));
            },
          ),
          ListTile(
            title: Text("מפת דרכים",
                textDirection: TextDirection.rtl,
                style: GoogleFonts.assistant()),
            onTap: () {

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Home()));
            },
          ),ListTile(
            title: Text("שאלון יומי",
                textDirection: TextDirection.rtl,
                style: GoogleFonts.assistant()),
            onTap: () {

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyQuestions()));
            },
          ),
          ListTile(
            title: Text("התנתק",
                textDirection: TextDirection.rtl,
                style: GoogleFonts.assistant()),
            onTap: () {
              Future<void> _signOut() async {
                await FirebaseAuth.instance.signOut();
              }

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Login()));
            },
          ),
        ]),
      ),
      body: Stack(children: [
        Positioned(
            top: -150,
            child: Container(
              child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 0.7),
                  duration: Duration(seconds: 1),
                  builder:
                      (BuildContext context, double percent, Widget? child) {
                    return CustomPaint(
                        painter: _LoadBar(
                            percent: 0, size: MediaQuery.of(context).size),
                        size: MediaQuery.of(context).size);
                  }),
              // color:Colors.green
            )),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            child: FloatingActionButton(
              elevation: 0,
              disabledElevation: 0,
              backgroundColor: Colors.grey.shade400,
              onPressed: () {
                if(this.widget.prev==1)
                  Navigator.pushNamed(context,'/tools');
                else
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => Home()),
                );
              },
              child: Icon(Icons.arrow_forward),
            ),
            margin: EdgeInsets.all(30),
          ),
        ),
        Column(children: [
          Container(
            height: 40,
          ),
          Row(
            children: [
              FlatButton(
                color: Colors.transparent,
                onPressed:  () => scaffoldKey.currentState!.openDrawer(),
                child: new IconTheme(
                  data: new IconThemeData(size: 35, color: Colors.black),
                  child: new Icon(Icons.menu_rounded),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "           הרפיית רגש",
                  //textAlign: TextAlign.center,
                  style: GoogleFonts.assistant(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          )
        ]),
        Positioned(
          top: 113,
          left: 320,
          child: Container(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Image.asset('images/expo/smile.png',
                  color: Color(0xffB3E8EF)),
            ),
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff35258A),
            ),
          ),
        ),
        Positioned(
            right: 10,
            left: 10,
            top: height * 0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Container(
                    child: Center(
                      child: Text(
                        '?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, //3
                      color: Color(0xffc4c4c4),
                    ),
                  ),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: AlertDialog(
                        backgroundColor: Color(0xffECECEC),
                        content: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            style: GoogleFonts.assistant(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: <TextSpan>[
                              //
                              TextSpan(text: 'עוד לא הוכנס מלל.\n'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text(
                              'x',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 40),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "זהו את עוצמת הרגש מ- 0-10",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.assistant(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 20),
              ],
            )),
        Positioned(
            top: height * 0.3,
            left: width * 0.33 - 20,
            child: Container(
                height: 500,
                width: 470,
                child: Stack(children: [
                  Positioned(
                      left: 20, child: Image.asset('images/ColorSlider.png')),
                  Positioned(
                      top: 0,
                      left: 25,
                      child: Container(
                          height: 460,
                          width: 10,
                          child: Opacity(
                            opacity: 0.5,
                            child: SfSliderTheme(
                                data: SfSliderThemeData(
                                    activeTrackColor: Colors.transparent,
                                    disabledActiveTrackColor:
                                        Colors.transparent,
                                    thumbStrokeColor: Colors.transparent,
                                    overlayColor: Colors.transparent,
                                    disabledInactiveTrackColor:
                                        Colors.transparent,
                                    inactiveTrackColor: Colors.transparent,
                                    thumbRadius: 20 + (feeling / 10),
                                    thumbColor: Colors.white),
                                child: SfSlider.vertical(
                                  value: feeling.round(),
                                  min: 0,
                                  max: 100,
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      feeling = value;
                                    });
                                  },
                                )),
                          ))),
                  Positioned(
                    top: 30,
                    left: 30,
                    child: Container(
                      width: 127,
                      height: 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0x2d34248a),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      left: 90,
                      child: Text(
                        "ממש מפחיד",
                        style: GoogleFonts.assistant(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )),
                  Positioned(
                    top: 180,
                    left: 30,
                    child: Container(
                      width: 127,
                      height: 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0x2d34248a),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 160,
                      left: 95,
                      child: Text(
                        "קצת מפחיד",
                        style: GoogleFonts.assistant(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )),
                  Positioned(
                    top: 320,
                    left: 30,
                    child: Container(
                      width: 127,
                      height: 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0x2d34248a),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 300,
                      left: 125,
                      child: Text(
                        "מעורר",
                        style: GoogleFonts.assistant(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )),
                  Positioned(
                    top: 440,
                    left: 30,
                    child: Container(
                      width: 127,
                      height: 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0x2d34248a),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 420,
                      left: 125,
                      child: Text(
                        "רגוע",
                        style: GoogleFonts.assistant(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ))
                ]))),
        Positioned(
            top: height * 0.94,
            right: width * 0.50,
            child: (feeling > 50)
                ? Text(
                    "בואו ננסה להקל :)",
                    textDirection: TextDirection.rtl,
                  )
                : Container()),
        Positioned(
            top: height * 0.92,
            right: width * 0.8,
            child: (feeling > 50)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff35258a),
                          shape: CircleBorder(),
                          fixedSize: Size(55, 55),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/second');
                        },
                      )
                    ],
                  )
                : Container())

        /*
      right:20,
          left:20,
          top:height*0.35,
            child:Container(
          width: 362,
          height: 258,
          child: Stack(
            children:[Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child:
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/second');
                  },
                    child:Container(
                  width: 173,
                  height: 118,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffe0cbdd),
                  ),
                  padding: const EdgeInsets.only(top: 37, bottom: 32, ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      SizedBox(
                        width: 169,
                        height: 23,
                        child: Text(
                          "הרפיית שרירים",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.assistant(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
                      SizedBox(
                        width: 173,
                        height: 19,
                        child: Text(
                          "3 דקות",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.assistant(
                          color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 173,
                    height: 118,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffdeeef3),
                    ),
                    padding: const EdgeInsets.only(top: 67, bottom: 32, ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:[
                        SizedBox(
                          width: 173,
                          height: 19,
                          child: Text(
                            "2 דקות",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.assistant(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 173,
                    height: 118,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0x42cfc780),
                    ),
                    padding: const EdgeInsets.only(top: 39, bottom: 30, ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        SizedBox(
                          width: 169,
                          height: 23,
                          child: Text(
                            "דמיון מודרך",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.assistant(

                            color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        SizedBox(
                          width: 173,
                          height: 19,
                          child: Text(
                            "7 דקות",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.assistant(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 173,
                    height: 118,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0x428f52cc),
                    ),
                    padding: const EdgeInsets.only(top: 67, bottom: 32, ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:[
                        SizedBox(
                          width: 173,
                          height: 19,
                          child: Text(
                            "10 דקות",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.assistant(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 188,
                top: 37,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    "תרגילי נשימה",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.assistant(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 188,
                top: 177,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    "מדיטציה",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.assistant(

                    color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),],
          ),
        )*/

        ]),
    );
  }
}

class _Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<_Page2> {
  FlutterLocalNotificationsPlugin  fltrNotification= FlutterLocalNotificationsPlugin();
  Future<AvatarData>? _adata;
  Future<String>? _name;
  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _adata = AvatarData.load();
    _name = _getname();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iOSinitialize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(android: androidInitialize , iOS:iOSinitialize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings);
  }
  Future _showNotification() async{
    var androidDetails= new AndroidNotificationDetails("ChannelId","Local Notification");
    var iosDetails= new IOSNotificationDetails();
    var generalNotificationDetails=new NotificationDetails(android: androidDetails, iOS: iosDetails);

    var scheduledTime = DateTime.now().add(Duration(minutes : 3));
    fltrNotification.schedule(1, "הרפיית רגש", "מקווה שנהניתם מהשיר! אל תשכחו לחזור אלי להמשך ההרפייה",
    scheduledTime, generalNotificationDetails);


  }

  Future<String> _getname() async {
    var name = (await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthRepository.instance().user?.uid)
        .get())['name'];
    print(name);
    return name;
  }
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(key: scaffoldKey,
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(children: [
                  Stack(
                    children: [
                      Positioned(
                          child: Image.asset('images/talky.png'),
                          top: 0,
                          right: 0),
                      Positioned(
                          top: 10,
                          right: 6,
                          child: FutureBuilder<String>(
                            future: _name,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              // ...
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                String data = snapshot.data ?? '';
                                return Text(
                                  'היי $data\n מה קורה?',
                                  textDirection: TextDirection.rtl,
                                  style: GoogleFonts.assistant(),
                                );
                              }
                              return CircularProgressIndicator();
                            },
                          )),
                    ],
                  ),
                  Positioned(
                      child: FutureBuilder<AvatarData>(
                        future: _adata,
                        builder: (BuildContext context,
                            AsyncSnapshot<AvatarData> snapshot) {
                          // ...
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AvatarStack(
                                data: (snapshot.data ??
                                    AvatarData(body: AvatarData.body_default)));
                          }
                          return CircularProgressIndicator();
                        },
                      )),
                ])),
            ListTile(
              title: Text("עצב דמות",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.assistant()),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Avatar(first: false, data: _adata)));
              },
            ),
            ListTile(
              title: Text("מפת דרכים",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.assistant()),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Home()));
              },
            ),ListTile(
              title: Text("שאלון יומי",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.assistant()),
              onTap: () {

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MyQuestions()));
              },
            ),
            ListTile(
              title: Text("התנתק",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.assistant()),
              onTap: () {
                Future<void> _signOut() async {
                  await FirebaseAuth.instance.signOut();
                }

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Login()));
              },
            ),
          ]),
        ),
        body: Stack(children: [
      Positioned(
          top: -150,
          child: Container(
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 0.7),
                duration: Duration(seconds: 1),
                builder: (BuildContext context, double percent, Widget? child) {
                  return CustomPaint(
                      painter: _LoadBar(
                          percent: 0, size: MediaQuery.of(context).size),
                      size: MediaQuery.of(context).size);
                }),
            // color:Colors.green
          )),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          child: FloatingActionButton(
            elevation: 0,
            disabledElevation: 0,
            backgroundColor: Colors.grey.shade400,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_forward),
          ),
          margin: EdgeInsets.all(30),
        ),
      ),
      Column(children: [
        Container(
          height: 40,
        ),
        Row(
          children: [
            FlatButton(
              color: Colors.transparent,
              onPressed:  () => scaffoldKey.currentState!.openDrawer(),
              child: new IconTheme(
                data: new IconThemeData(size: 35, color: Colors.black),
                child: new Icon(Icons.menu_rounded),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "           הרפיית רגש",
                //textAlign: TextAlign.center,
                style: GoogleFonts.assistant(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        )
      ]),
      Positioned(
        top: 113,
        left: 320,
        child: Container(
          padding: EdgeInsets.all(5),
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child:
                Image.asset('images/expo/smile.png', color: Color(0xffB3E8EF)),
          ),
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff35258A),
          ),
        ),
      ),
      Positioned(
          right: 10,
          left: 10,
          top: height * 0.25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  child: Center(
                    child: Text(
                      '?',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, //3
                    color: Color(0xffc4c4c4),
                  ),
                ),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: AlertDialog(
                      backgroundColor: Color(0xffECECEC),
                      content: RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          style: GoogleFonts.assistant(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          children: <TextSpan>[
                            //
                            TextSpan(text: 'עוד לא הוכנס מלל.\n'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text(
                            'x',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(width: 10),

              Container(
                margin: EdgeInsets.only(right: 10, left: 0, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "בואו נסיח את עצמנו ונשנה ערוץ!",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      //
                      "התמקדו במשהו המעורר בך רגשות חיוביים:\n\n\nלמשל, בחרי בשיר אהוב המעודד אותך והקשיבי לו\nעל ידי לחיצה על הפלטפורמה המעודפת עלייך -\n  ",
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.assistant(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),

                  ],
                ),
              ),

              Container(width: 20),
            ],
          )),

          Positioned(bottom:170,right:202,child:Stack(children:[Image.asset("images/talk.png"),Positioned(top:20,left:20,child:Container(width:125,height:90,child:Text("תוכלו לבחור גם בדרכים אחרות כמו בתעמלות שיחה עם חבר, אומנות או יצירה",textDirection: TextDirection.rtl,)))])),
          Positioned(
            left:0,
              right:0,
              top:height*0.5,
              child:
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                GestureDetector(child:Container(height:80,child:Stack(children:[Image.asset('images/spotify.png'),Positioned(bottom:0,left:8,right:8,child:Text("Spotify",style:GoogleFonts.assistant(fontSize:14,fontWeight: FontWeight.w600)))])),
                onTap: () async {
                  _showNotification();
                  bool isInstalled =
                  await DeviceApps.isAppInstalled('spotify');

                  if (isInstalled != false) {
                    AndroidIntent intent = AndroidIntent(
                        action: 'action_view', data: 'spotify');
                    await intent.launch();
                  } else {
                    String url = 'com.spotify.music';
                    print(await DeviceApps.getApp('Spotify'));
                    DeviceApps.openApp('com.spotify.music');
                  }
                },
              ),
                GestureDetector(child:Container(height:80,child:Stack(children:[Image.asset('images/youtube.png'),Positioned(right:2,left:2,bottom:0,child:Text("YouTube",style:GoogleFonts.assistant(fontSize:14,fontWeight: FontWeight.w600)))])),
                onTap: () async {
                  _showNotification();
                  bool isInstalled =
                  await DeviceApps.isAppInstalled('youtube');

                  if (isInstalled != false) {
                    AndroidIntent intent = AndroidIntent(
                        action: 'action_view', data: 'youtube');
                    await intent.launch();
                  } else {
                    String url = 'com.spotify.music';
                    print(await DeviceApps.getApp('Spotify'));
                    DeviceApps.openApp('com.google.android.youtube');
                  }
                },
              ),
                GestureDetector(child:Container(height:80,child:Stack(children:[Image.asset('images/apple-music.png'),Positioned(bottom:0,left:7,right:7,child:Text("Apple",style:GoogleFonts.assistant(fontSize:14,fontWeight: FontWeight.w600)))])),
                onTap: () async {
                  _showNotification();
                  bool isInstalled =
                  await DeviceApps.isAppInstalled('com.apple.android.music');

                  if (isInstalled != false) {
                    AndroidIntent intent = AndroidIntent(
                        action: 'action_view', data: 'com.apple.android.music');
                    await intent.launch();
                  } else {
                    DeviceApps.openApp('com.apple.android.music');
                  }
                },
              ),

              ]))
          ,Positioned(bottom:20,right:10,child:Image.asset("images/skater2.png")),
          Positioned(bottom:28,left:21,child:
          Stack(children: [
            Container(
                width: 142,
                height: 39,
                child: MaterialButton(
                    onPressed: () {
                          Navigator.pushNamed(context, '/tools');
                    },
                    minWidth: 142,
                    height: 39,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36)),
                    color: Color(0xff35258a),
                    child: Stack(children: <Widget>[
                      Positioned(
                        top: 5,
                        right: 15,
                        child: Text(
                          "סיימתי!",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.assistant(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ]))),
            Positioned(
                top: 5,
                right: 110,
                child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(color: Colors.white, width: 9),
                    ))),
          ])
          )

    ]));
  }
}

class _Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<_Main> {
  int choose = -1;

  Future<AvatarData>? _adata;
  Future<String>? _name;
  @override
  void initState() {
    super.initState();
    _adata = AvatarData.load();
    _name = _getname();
  }

  Future<String> _getname() async {
    var name = (await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthRepository.instance().user?.uid)
        .get())['name'];
    print(name);
    return name;
  }
  var scaffoldKey = GlobalKey<ScaffoldState>();
  /**/

  @override
  Widget build(BuildContext context) {
    print('main');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(key: scaffoldKey,
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(children: [
                  Stack(
                    children: [
                      Positioned(
                          child: Image.asset('images/talky.png'),
                          top: 0,
                          right: 0),
                      Positioned(
                          top: 10,
                          right: 6,
                          child: FutureBuilder<String>(
                            future: _name,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              // ...
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                String data = snapshot.data ?? '';
                                return Text(
                                  'היי $data\n מה קורה?',
                                  textDirection: TextDirection.rtl,
                                  style: GoogleFonts.assistant(),
                                );
                              }
                              return CircularProgressIndicator();
                            },
                          )),
                    ],
                  ),
                  Positioned(
                      child: FutureBuilder<AvatarData>(
                        future: _adata,
                        builder: (BuildContext context,
                            AsyncSnapshot<AvatarData> snapshot) {
                          // ...
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AvatarStack(
                                data: (snapshot.data ??
                                    AvatarData(body: AvatarData.body_default)));
                          }
                          return CircularProgressIndicator();
                        },
                      )),
                ])),
            ListTile(
              title: Text("עצב דמות",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.assistant()),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Avatar(first: false, data: _adata)));
              },
            ),
            ListTile(
              title: Text("מפת דרכים",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.assistant()),
              onTap: () {

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Home()));
              },
            ),ListTile(
              title: Text("שאלון יומי",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.assistant()),
              onTap: () {

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MyQuestions()));
              },
            ),
            ListTile(
              title: Text("התנתק",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.assistant()),
              onTap: () {
                Future<void> _signOut() async {
                  await FirebaseAuth.instance.signOut();
                }

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Login()));
              },
            ),
          ]),
        ),
        body: Stack(children: [
      Positioned(
          top: -150,
          child: Container(
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 0.7),
                duration: Duration(seconds: 1),
                builder: (BuildContext context, double percent, Widget? child) {
                  return CustomPaint(
                      painter: _LoadBar(
                          percent: 0, size: MediaQuery.of(context).size),
                      size: MediaQuery.of(context).size);
                }),
            // color:Colors.green
          )),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          child: FloatingActionButton(
            elevation: 0,
            disabledElevation: 0,
            backgroundColor: Colors.grey.shade400,
            onPressed: ()  {
               Navigator.pushNamed(context,'/tools');
            },
            child: Icon(Icons.arrow_forward),
          ),
          margin: EdgeInsets.all(30),
        ),
      ),
      Column(
        children: [
          Container(
            height: 40,
          ),
          Row(
            children: [
              FlatButton(
                color: Colors.transparent,
                onPressed:  () => scaffoldKey.currentState!.openDrawer(),
                child: new IconTheme(
                  data: new IconThemeData(size: 35, color: Colors.black),
                  child: new Icon(Icons.menu_rounded),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "                  זיהוי",
                  //textAlign: TextAlign.center,
                  style: GoogleFonts.assistant(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ), //1
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  child: Center(
                    child: Text(
                      '?',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, //3
                    color: Color(0xffc4c4c4),
                  ),
                ),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: AlertDialog(
                      backgroundColor: Color(0xffECECEC),
                      content: RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          style: GoogleFonts.assistant(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          children: <TextSpan>[
                            //
                            TextSpan(text: 'עוד לא הוכנס מלל.\n'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text(
                            'x',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(width: 80),
              Container(
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "בואי נזהה יחד את החרדה",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    Text(
                      "בחרי עם איזה זיהוי להתחיל",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 20),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TweenAnimationBuilder<double>(
              tween: Tween<double>(
                  begin: (choose == -1) ? 0.5 : 0.8,
                  end: (choose == -1) ? 0.8 : 0.5),
              duration: Duration(milliseconds: 500),
              builder: (BuildContext context, double percent, Widget? child) {
                return Container(
                  width: (choose == -1) ? width : width * percent,
                  child: Consumer<ExpoData>(
                    builder: (context, data, w) {
                      print(data.done);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _MyButton(
                              isDone: data.done[0],
                              isSelected: (choose == 0),
                              name: 'גוף',
                              func: () {
                                setState(() {
                                  choose = 0;
                                });
                              },
                              image: 'images/expo/meditate.png'),
                          _MyButton(
                              isDone: data.done[1],
                              isSelected: (choose == 1),
                              name: 'רגשות',
                              func: () {
                                setState(() {
                                  choose = 1;
                                });
                              },
                              image: 'images/expo/smile.png'),
                          _MyButton(
                              isDone: data.done[2],
                              isSelected: (choose == 2),
                              name: 'מחשבות',
                              func: () {
                                setState(() {
                                  choose = 2;
                                });
                              },
                              image: 'images/expo/brain.png'),
                        ],
                      );
                    },
                  ),
                );
              }),
          if (choose != -1)
            Flexible(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: width * 0.9,
                  height: 247,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3f000000),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                    color: _color(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          _title(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Assistant",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        margin: EdgeInsets.all(30),
                      ),
                      Container(
                        child: Text(
                          _text(),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        margin: EdgeInsets.only(left: 30, right: 30),
                      ),
                    ],
                  )),
            ),
        ],
      ),
      Positioned(
          top: height * 0.92,
          right: width * 0.8,
          child: (choose != -1)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff35258a),
                        shape: CircleBorder(),
                        fixedSize: Size(55, 55),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (choose == 2) {
                          await Navigator.pushNamed(context, '/thoughts/1');
                        } else if (choose == 0) {
                          await Navigator.pushNamed(context, '/body/1');
                        } else if (choose == 1) {
                          await Navigator.pushNamed(context, '/feelings/1');
                        }
                        setState(() {
                          choose = -1;
                        });
                      },
                    )
                  ],
                )
              : Container()),
    ]));
  }

  String _title() {
    var x = Provider.of<ExpoData>(context, listen: false).introductions;
    if (choose == 0) return x[0].item1;
    if (choose == 1) return x[1].item1;
    if (choose == 2) return x[2].item1;
    return '';
  }

  String _text() {
    var x = Provider.of<ExpoData>(context, listen: false).introductions;
    if (choose == 0) return x[0].item2;
    if (choose == 1) return x[1].item2;
    if (choose == 2) return x[2].item2;
    return '';
  }

  Color _color() {
    var x = Provider.of<ExpoData>(context, listen: false).colors;
    if (choose == 0) return x[1];
    if (choose == 1) return x[2];
    if (choose == 2) return x[0];
    return Color(0xffefd6ee);
  }
}

class _MyButton extends StatelessWidget {
  _MyButton(
      {required this.isSelected,
      required this.name,
      required this.func,
      required this.image,
      this.isDone = false});
  final bool isSelected, isDone;
  final String name, image;
  final func;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: GestureDetector(
      child: Column(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.15),
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Image.asset(
                        image,
                        color: (isDone)
                            ? Color(0xffEDEBEB)
                            : (isSelected)
                                ? Color(0xffB3E8EF)
                                : Color(0xff35258A),
                      )),
                  margin: EdgeInsets.all(constraints.maxWidth * 0.08),
                  width: constraints.maxWidth,
                  height: constraints.maxWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isDone)
                        ? Color(0xffABAAAA)
                        : (isSelected)
                            ? Color(0xff35258A)
                            : Color(0xffdee8f3),
                  ),
                ),
                if (isDone)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      padding: EdgeInsets.all(constraints.maxWidth * 0.05),
                      margin: EdgeInsets.only(
                          top: constraints.maxWidth * 0.04,
                          right: constraints.maxWidth * 0.08),
                      width: constraints.maxWidth * 0.25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff808080),
                      ),
                    ),
                  )
              ],
            );
          }),
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          )
        ],
      ),
      onTap: func,
    ));
  }
}

class ExpoData {
  ExpoData(
      {required this.adata,
      required this.theCase,
      required this.body_task,
      required this.feelings_task,
      required this.thoughts_task}) {
    while (feelings.length % 8 != 0) {
      feelings.add('');
    }

    introductions = [
      all_introductions[0][body_task],
      all_introductions[1][feelings_task],
      all_introductions[2][thoughts_task]
    ];
  }
  int body_task, feelings_task, thoughts_task;
  String theCase;
  List<Color> colors = [
    Color(0xfff3f1de),
    Color(0xffdef3df),
    Color(0xffefd6ee)
  ];
  List<List<Tuple2<String, String>>> all_introductions = [
    [Tuple2('זיהוי גוף', 'חשוב שנלמד לזהות כיצד הגוף משפיע על החרדה שלנו.')],
    [Tuple2('זיהוי רגשות', 'הרגש הוא חלק מהותי מן החרדה שלנו......')],
    [Tuple2('זיהוי מחשבות', 'המחשבות הם מחל מהמחשבה, וחשוב שנאתרן...')]
  ];
  List<Tuple2<String, String>> introductions = [];

  List<bool> done = [false, false, false];
  int stress = 50;
  List<String> thoughts = [
    'אני תמיד אגיד או אעשה משהו...',
    'הכי נורא שיכול לקרות זה...',
    'תמיד כשאני עושה דברים כאלו...',
    'אף אחד אף פעם לא אוהב ש...',
    'אני מרגישה לא בנוח ולכן...',
    'אני לא אדע איך...'
  ];
  List<String> replies = ['', '', '', '', '', ''];
  List<String> feelings = [
    'סיבוך',
    'פגיעות',
    'עצב',
    'בדידות',
    'ריקנות',
    'אבודה',
    'נידוי',
    'אכזבה',
    'בחילה',
    'תיעוב',
    'גועל',
    'חוסר נוחות',
    'היסוס',
    'אדישות',
    'חרטה',
    'מוצף',
    'מפוחד',
    'מופתע',
    'נואשות',
    '',
    'לחץ',
    'מבועט',
    'ספקנות',
    'פאניקה',
    'ביטחון עצמי',
    'השראה',
    'ריגוש',
    'תקווה',
    '',
    'גאווה',
    'שמחה',
    'הקלה',
    'מרמור',
    'השפלה',
    '',
    'מופתע',
    'נואשות',
    'כעס',
    'עצבנות',
    'תסכול',
    'רוגז',
    'קימום'
  ];
  List<int> felt = [];

  List<String> painSpots = [];
  AvatarData adata;
}

class _LoadBar extends CustomPainter {
  final double percent;
  final Size size;

  _LoadBar({
    required this.percent,
    required this.size,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var painter = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    Offset center = Offset(size.width / 2, -size.width * 0.3);

    canvas.drawCircle(
        center,
        size.width * 1.05,
        painter
          ..color = Color(0xffeffbff)
          ..style = PaintingStyle.fill);
    if (percent != -1)
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: size.width * 1.05),
          0,
          pi,
          false,
          painter
            ..color = Color(0xffc4c4c4)
            ..style = PaintingStyle.stroke);
    else
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: size.width * 1.05),
          0,
          pi,
          false,
          painter
            ..color = Color(0xffDEF3DF)
            ..style = PaintingStyle.stroke);

    double pad = 0.2;
    if (percent != -1)
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: size.width * 1.05),
          0,
          pi / 2 - pi / 6 + pad,
          false,
          painter
            ..color = Color(0xff35258A)
            ..style = PaintingStyle.stroke);
    if (percent != -1)
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: size.width * 1.05),
          pi / 2 - pi / 6 + pad,
          (2 * pi / 6 - 2 * pad) * percent,
          false,
          painter..color = Color(0xff35258A));

    Offset off1 = center +
        Offset(-sin(pi / 6 - pad) * size.width, cos(pi / 6 - pad) * size.width);
    painter
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    Offset off2 = center + //
        Offset(sin(pi / 6 - pad) * size.width, cos(pi / 6 - pad) * size.width);
    painter
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
  }

  @override
  bool shouldRepaint(_LoadBar oldDelegate) {
    return percent != oldDelegate.percent;
  }
}

class _PaintTask extends CustomPainter {
  final int slices, complete;

  _PaintTask({required this.slices, required this.complete});

  @override
  void paint(Canvas canvas, Size size) {
    double sw = 7;
    var painter = Paint()
      ..color = Color(0xFFC4C4C4)
      // ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = sw;
    Offset c = Offset(size.height / 2, size.width / 2);
    double radius = size.height / 2;
    canvas.drawCircle(c, radius, painter);
    canvas.drawArc(Rect.fromCircle(center: c, radius: radius), -pi / 2,
        2 * pi * complete / slices, false, painter..color = Colors.green);

    if (slices > 1 && slices < 21) {
      for (int i = 0; i < slices; i++) {
        var painter2 = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

        double phea = 2 * pi * i / slices - pi / 2;
        Offset start = c +
            Offset(
                (radius - sw / 2) * cos(phea), (radius - sw / 2) * sin(phea));
        Offset end = c +
            Offset(
                (radius + sw / 2) * cos(phea), (radius + sw / 2) * sin(phea));
        canvas.drawLine(start, end, painter2);
      }
    }
    canvas.drawCircle(
        Offset(size.height / 2, size.width / 2),
        radius * 0.85,
        painter
          ..style = PaintingStyle.fill
          ..color = Color(0xFFEBE9D6));
  }

  @override
  bool shouldRepaint(_PaintTask oldDelegate) {
    return (slices != oldDelegate.slices) || (complete != oldDelegate.complete);
  }
}
