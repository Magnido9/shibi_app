import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_services.dart';

class AvatarData {
  AvatarData({required this.body, this.glasses});
  String body;
  String? glasses;
  int color=0;
  static String body_default = "images/poo.png";
  static Future<AvatarData> load() async {
    String? pid = AuthRepository.instance().user?.uid;
    var v =
        (await FirebaseFirestore.instance.collection("avatars").doc(pid).get());
    return AvatarData(body: v['body'], glasses: v['glasses']);
  }
}

class Avatar extends StatelessWidget {
  // This widget is the root of your application.
  Avatar({required this.first});
  final bool first;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (first)
          ? AvatarPage(
              title: "hey", data: AvatarData(body: AvatarData.body_default))
          : FutureBuilder(
              future: AvatarData.load(),
              builder:
                  (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
                if (snapshot.hasData) {
                  return AvatarPage(
                      title: "hey",
                      data: (snapshot.data ??
                          AvatarData(body: AvatarData.body_default)));
                } else
                  return AvatarPage(
                      title: "hey",
                      data: (AvatarData(body: AvatarData.body_default)));
              }),
    );
  }
}

class AvatarPage extends StatefulWidget {
  AvatarPage({Key? key, required this.title, required this.data})
      : super(key: key);
  final String title;

  @override
  _AvatarPageState createState() => _AvatarPageState();
  final AvatarData data;
}

class _AvatarPageState extends State<AvatarPage> {
  void _save() async {
    String? pid = AuthRepository.instance().user?.uid;
    await FirebaseFirestore.instance
        .collection("avatars")
        .doc(pid)
        .set({'body': widget.data.body, 'glasses': widget.data.glasses});
  }

  Widget _glasses(String image,int num) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          widget.data.color=1+num;
          widget.data.glasses = image;
        });
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
            border: Border.all(color:  widget.data.color==(1+num)?Color(0xff35258a):Color(0xffb9b8b8), width: 2, ),
            color:  widget.data.color==(1+num)?Color(0xffebdac7):Color(0xfff6f5ed),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.scaleDown

                )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double _min = min(_width, _height);
    return Scaffold(
        body: Stack(children: [

        Positioned(
            left: -0.8*MediaQuery.of(context).size.width ,
            top: -1.25* MediaQuery.of(context).size.height,
            child: Container(
                width: 0.8125 * MediaQuery.of(context).size.height*2,
                height: 0.8125 * MediaQuery.of(context).size.height*1.8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(
                      0xffecdbc7,
                    )))),
    Positioned(
    right: 25,
    top: 75,
    child: Align(
    alignment: Alignment.topRight,
    child: Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
    Text(
    "עיצוב השיבי שלך",
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.right,
    style: GoogleFonts.assistant(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.w900,
    ),

    //,"לכן, האפליקציה לא מאפשרת מענה חירום. n\את מה שאת מעלה בזמן אמת - n\אבל, המטפל/ת שלך לא תמיד רואה n\n\n\n\n\המועלה לאפליקציה. n\רק למטפל/ת שלך יש גישה למידע "
    ),

    ]))),
    Center(
          child: Column(
            children: <Widget>[
              Container(height:200),

              Container(
                  width: 128,
                  height: 128,
                  child: AvatarStack(
                    data: widget.data,
                  )),
              Container(height:10),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: <Widget>[
                    Container(width: 14),
                    Container(width: 14),
                    _glasses('images/glasses1.png',1),
                    Container(width: 14),
                    _glasses('images/glasses2.png',2),
                    Container(width: 14),
                    _glasses('images/glasses3.png',3),
                    Container(width: 14),
                    _glasses('images/glasses4.png',4),
                    Container(width: 14),
                    Container(width: 14),
                  ])),
              MaterialButton(
                onPressed: () => {
                  _save(),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Home()))
                },
                color: Colors.grey,
                child: Text("שמור"),
              ),],
          ),
        )]),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              onPressed: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Home()))
              },
              label: Text("חזור"),
            ),

          ],
        ));
  }
}

class AvatarStack extends StatelessWidget {
  AvatarStack({required this.data, Key? key}) : super(key: key);

  final AvatarData data;
  @override
  Widget build(BuildContext context) {
    return Center(child:
        LayoutBuilder(builder: (BuildContext context, BoxConstraints cons) {
      return Container(
          // color:Colors.grey,
          width: min(cons.maxWidth, cons.maxHeight),
          height: min(cons.maxWidth, cons.maxHeight),
          child: Stack(children: <Widget>[
            //body
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  child: FittedBox(
                    child: Image.asset(data.body),
                    fit: BoxFit.fill,
                  ),
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                );
              },
            ),

            //glasses
            if (data.glasses != null)
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(data.glasses ?? ''),
                          height: constraints.maxHeight / 8,
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight /20,
                            // left: constraints.maxWidth/14
                          ),
                        )
                      ]);
                },
              )
          ]));
    }));
  }
}

class LoadAvatar extends StatefulWidget {
  @override
  _LoadAvatarState createState() => _LoadAvatarState();
}

class _LoadAvatarState extends State<LoadAvatar> {
  Future<AvatarData>? _data;

  @override
  void initState() {
    super.initState();
    _data = AvatarData.load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _data,
        builder: (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
          if (snapshot.hasData) {
            return AvatarStack(
                data: (snapshot.data ??
                    AvatarData(body: AvatarData.body_default)));
          } else
            return CircularProgressIndicator(
              color: Colors.green,
            );
        });
  }
}
