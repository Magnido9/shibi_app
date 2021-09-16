library home;
import 'dart:math';

import 'package:application/screens/map/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Avatar/avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../login/login.dart';
import '../../services/auth_services.dart';


class Home extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  Future<AvatarData>? _adata;
  Future<String>? _name;


  @override
  void initState() {
    super.initState();
    _adata = AvatarData.load();
    _name =  _getname();
  }

  Future<String> _getname() async{
    return (await FirebaseFirestore.instance.collection("users").doc(AuthRepository.instance().user?.uid).get())['name'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home',
      home: Builder(
        builder: (context){
          var size=Size.square(min(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height));

          return Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder: (context) => GestureDetector(
                      onTap: (){ Scaffold.of(context).openDrawer();
                      print('fdfd');},
                      child: Icon(Icons.menu)
                  ),
                ) ,
              ),
              body: Stack(
                children: [
                  CustomPaint(
                      painter: _HomeScreenPainter(last:DateTime.now() ,current:DateTime.now(), target: DateTime.now(),size: size),
                      size: size
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [Container(
                        // color: Colors.green,
                          width: size.width*0.5,
                          height: size.height*0.5,
                          child: FutureBuilder<AvatarData>(
                            future: _adata,
                            builder: (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                var data = snapshot.data ?? AvatarData(body: AvatarData.body_default);
                                return AvatarStack(data: data);
                              }
                              return CircularProgressIndicator();
                            },
                          )
                      ),]
                  )
                ],
              ),
              drawer: Drawer(
                child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Row(
                            children: [
                              FutureBuilder<String>(
                                future: _name,
                                builder:
                                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                                  // ...
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    String data = snapshot.data ?? '';
                                    return Text('Hello $data');
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                              FutureBuilder<AvatarData>(
                                future: _adata,
                                builder:
                                    (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
                                  // ...
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return AvatarStack(data:( snapshot.data ?? AvatarData(body: AvatarData.body_default)) );

                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ],
                          )
                      ),
                      ListTile(
                        title: const Text("עצב דמות"),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) => Avatar(first:false)));
                          ///Navigator.push(context, MaterialPageRoute(builder: (context) => Avatar()));
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
                      ListTile(
                        title: const Text("מפה!"),
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

                    ]
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  type : BottomNavigationBarType.fixed,
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
                      label: 'פסיכנוך',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.accessibility_new_outlined),
                      label: 'תרגילים',
                    ),
                  ]
              )

          );},
      )
    );

      }
}


class _HomeScreenPainter extends CustomPainter {
 final DateTime current, target, last;
 final Size size;
  _HomeScreenPainter({
    required this.last,
    required this.current,
    required this.target,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var painter=Paint()
      ..color = Colors.lightGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth =15;
    Offset center = Offset(size.width/2,-size.width*0.3);
    canvas.drawArc(Rect.fromCircle(center:center , radius: size.width), 0,pi, false, painter);
    double pad=0.1;
    double prog= ((target.day-last.day)==0)?1:(target.day-current.day)/(target.day-last.day);
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width), pi/2-pi/6+pad ,(2*pi/6-2*pad)*prog, false, painter..color=Colors.deepPurple);

    Offset off1= center+Offset(-sin(pi/6-pad)*size.width, cos(pi/6-pad)*size.width);
    painter..color = Colors.grey..style = PaintingStyle.fill..strokeWidth = 2;
    canvas.drawCircle(off1, size.width*0.04, painter);
    canvas.drawCircle(off1, size.width*0.03, painter..color=Colors.white);

    Offset off2= center+Offset(sin(pi/6-pad)*size.width, cos(pi/6-pad)*size.width);
    painter..color = Colors.grey..style = PaintingStyle.fill..strokeWidth = 2;
    canvas.drawCircle(off2, size.width*0.04, painter);
    canvas.drawCircle(off2, size.width*0.03, painter..color=Colors.white);
  }


  @override
  bool shouldRepaint(_HomeScreenPainter oldDelegate) {

    return current != oldDelegate.current;
  }
}
