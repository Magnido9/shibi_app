library home;

import 'dart:math';

import 'package:application/screens/home/psycho.dart';
import 'package:application/screens/map/map.dart';
import 'package:application/screens/map/meditation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Avatar/avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../login/login.dart';
import '../../services/auth_services.dart';
import 'home.dart';

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  Future<AvatarData>? _adata;
  Future<String>? _name;

  @override
  void initState() {
    super.initState();
    _adata = AvatarData.load();
    _name = _getname();
  }

  Future<String> _getname() async {
    return (await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthRepository.instance().user?.uid)
        .get())['name'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'home',
        home: Builder(
          builder: (context) {
            var x = min(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height);
            var size = Size(x, 0.7 * x);

            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.black),
                  leading: Builder(
                    builder: (context) => GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                          print('fdfd');
                        },
                        child: Icon(Icons.menu)),
                  ),
                ),
                body: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: 0.7),
                              duration: Duration(seconds: 1),
                              builder: (BuildContext context, double percent,
                                  Widget? child) {
                                return CustomPaint(
                                    painter:
                                    _LoadBar(percent: percent, size: size),
                                    size: size);
                              }),
                          // color:Colors.green
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // color: Colors.green,
                                  width: size.width * 0.5,
                                  height: size.height,
                                  child: FutureBuilder<AvatarData>(
                                    future: _adata,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<AvatarData> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        var data = snapshot.data ??
                                            AvatarData(
                                                body: AvatarData.body_default , );
                                        return AvatarStack(data: data);
                                      }
                                      return CircularProgressIndicator();
                                    },
                                  )),
                            ])
                      ],
                    ),
                    Container(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: 100,
                            height: 100,
                            child: _TaskIcon(
                              daily: true,
                              text: 'test',
                              slices: 5,
                              complete: 3,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                drawer: Drawer(
                  child: ListView(padding: EdgeInsets.zero, children: [
                    DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Row(
                          children: [
                            FutureBuilder<String>(
                              future: _name,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                // ...
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  String data = snapshot.data ?? '';
                                  return Text('Hello $data');
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<AvatarData>(
                              future: _adata,
                              builder: (BuildContext context,
                                  AsyncSnapshot<AvatarData> snapshot) {
                                // ...
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return AvatarStack(
                                      data: (snapshot.data ??
                                          AvatarData(
                                              body: AvatarData.body_default , )));
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                          ],
                        )),
                    ListTile(
                      title: const Text("עצב דמות"),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Avatar(first: false)));

                        ///Navigator.push(context, MaterialPageRoute(builder: (context) => Avatar()));
                        ///Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text("מפה"),
                      onTap: () {
                        Future<void> _signOut() async {
                          await FirebaseAuth.instance.signOut();
                        }

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => MapPage()));

                        ///Navigator.push(context, MaterialPageRoute(builder: (context) => Login(isInit: false)));
                        ///Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text("אין לי מה לעשות אז מדיטציה"),
                      onTap: () {
                        Future<void> _signOut() async {
                          await FirebaseAuth.instance.signOut();
                        }

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                StopWatchTimerPage()));

                        ///Navigator.push(context, MaterialPageRoute(builder: (context) => Login(isInit: false)));
                        ///Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text("התנתק"),
                      onTap: () {
                        Future<void> _signOut() async {
                          await FirebaseAuth.instance.signOut();
                        }

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => Login()));

                        ///Navigator.push(context, MaterialPageRoute(builder: (context) => Login(isInit: false)));
                        ///Navigator.pop(context);
                      },
                    ),
                  ]),
                ),
                bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: 1,
                    onTap: (int page) {
                      if (page == 0) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Home()));
                      }
                      if (page == 1) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Diary()));
                      }
                      if (page == 2) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Psycho()));
                      }
                      if (page == 3) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StopWatchTimerPage()));
                      }
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.thumb_up_outlined),
                        label: 'מפת דרכים',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.cloud_queue_rounded),
                        label: 'יומן',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.face),
                        label: 'פסיכוחינוך',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.accessibility_new_outlined),
                        label: 'תרגילים',
                      ),
                    ]));
          },
        ));
  }
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
      ..color = Colors.lightGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
    Offset center = Offset(size.width / 2, -size.width * 0.3);
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width), 0, pi,
        false, painter);
    double pad = 0.1;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width),
        pi / 2 - pi / 6 + pad,
        (2 * pi / 6 - 2 * pad) * percent,
        false,
        painter..color = Colors.deepPurple);

    Offset off1 = center +
        Offset(-sin(pi / 6 - pad) * size.width, cos(pi / 6 - pad) * size.width);
    painter
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.drawCircle(off1, size.width * 0.04, painter);
    canvas.drawCircle(off1, size.width * 0.03, painter..color = Colors.white);

    Offset off2 = center +
        Offset(sin(pi / 6 - pad) * size.width, cos(pi / 6 - pad) * size.width);
    painter
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.drawCircle(off2, size.width * 0.04, painter);
    canvas.drawCircle(off2, size.width * 0.03, painter..color = Colors.white);
  }

  @override
  bool shouldRepaint(_LoadBar oldDelegate) {
    return percent != oldDelegate.percent;
  }
}

class _TaskIcon extends StatelessWidget {
  _TaskIcon(
      {this.text,
        this.surprise = false,
        this.daily = false,
        required this.slices,
        required this.complete});

  final String? text;
  final bool surprise, daily;
  final int slices, complete;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                height: 0.7 * min(constraints.maxWidth, constraints.maxHeight),
                width: 0.7 * min(constraints.maxWidth, constraints.maxHeight),
                child: Stack(children: [
                  CustomPaint(
                    size: Size.square(
                        0.7 * min(constraints.maxWidth, constraints.maxHeight)),
                    painter: _PaintTask(slices: slices, complete: complete),
                  ),
                  Center(
                    child: Container(
                      height: 0.5 * constraints.maxHeight,
                      width: 0.5 * constraints.maxWidth,
                      child: Center(
                        child: Text(
                          (surprise)
                              ? '?'
                              : ((daily)
                              ? date.day.toString() +
                              '/' +
                              (date.month.toString())
                              : ""),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              if (daily) Text('עדכון יומי'),
              if (surprise) Text('הפתעה'),
              if (text != null && !daily && !surprise) Text((text ?? ''))
            ],
          );
        });
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
