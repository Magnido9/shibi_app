
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../home/home.dart';
import 'package:application/screens/login/password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_services.dart';

String _body_default='images/poo.png';

class AvatarData{
  AvatarData({required this.body, this.glasses});
  String body;
  String? glasses;
}

class Avatar extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AvatarPage(title: 'Avatar'),
    );
  }
}

class AvatarPage extends StatefulWidget {
  AvatarPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AvatarPageState createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {

  AvatarData data = AvatarData(body:_body_default);

  void _save() async{
    String? pid = AuthRepository.instance().user?.uid;
    await FirebaseFirestore.instance.collection("avatars").doc(pid).set({
      'body': data.body,
      'glasses' : data.glasses
    });
  }


  Widget _glasses(String image){
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {  setState(() {data.glasses=image;}); },
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
                image:AssetImage(image),
                fit:BoxFit.contain
            )
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;
    double _min=min(_width, _height);
    return Scaffold(

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(margin: EdgeInsets.only(top:_min/8)),
            Text ("תלביש אותי מתוק",),
            Container(
                color: Colors.green,
                width:_min/2 ,
                height: _min/2,
                child: AvatarStack(data: data,)),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(children: <Widget>[
                  _glasses('images/glasses1.png'),
                  _glasses('images/glasses2.png'),
                  _glasses('images/glasses3.png'),
                  _glasses('images/glasses4.png'),
                  _glasses('images/glasses5.png'),

                ]))
          ],
        ),
         ),  floatingActionButton:
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
      FloatingActionButton.extended(
        onPressed: ()=>{Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => Home()))},
        label:Text("חזור"),),
      FloatingActionButton.extended(
        onPressed: ()=>{
          _save(),
        Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => Home()))},
        label:Text("שמור"),),


    ],)
    );

  }

}

class AvatarStack extends StatelessWidget{
  AvatarStack({required this.data, Key? key}) :super(key:key);

  final AvatarData data;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints cons){
            return Container(
              width: min(cons.maxWidth, cons.maxHeight),
              height: min(cons.maxWidth, cons.maxHeight),
              child: Stack(
                  children:
                  <Widget>[
                    Center(child:Image.asset(data.body)),
                    if(data.glasses!=null)
                      LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints){
                        return Row(mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Container(
                                child: Image.asset(data.glasses ?? ''),
                                height: constraints.maxHeight/4,
                                margin: EdgeInsets.only(
                                  top: constraints.maxHeight/5,
                                  // left: constraints.maxWidth/14
                                ),

                              )]);

                      }
                        ,)
                  ]
              )
            );
          }
        )
    );
  }

}

class LoadAvatar extends StatefulWidget{

  @override
  _LoadAvatarState createState() =>_LoadAvatarState();
}

class _LoadAvatarState extends State<LoadAvatar> {
  Future<AvatarData>? _data;

  @override
  void initState() {
    super.initState();
    _data = _load();
  }
  Future<AvatarData> _load() async{
    String? pid = AuthRepository.instance().user?.uid;
    return AvatarData(
        body: (await FirebaseFirestore.instance.collection("avatars").doc(pid).get())[ 'body'],
        glasses:(await FirebaseFirestore.instance.collection("avatars").doc(pid).get())[ 'glasses']
    );

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _data,
        builder: (BuildContext context, AsyncSnapshot<AvatarData> snapshot){
          if(snapshot.hasData){ return AvatarStack(data:( snapshot.data ?? AvatarData(body: _body_default)) );}
          else return  CircularProgressIndicator();
        }


    );


  }

}


