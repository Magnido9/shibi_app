
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AvatarPageState createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  String glasses='images/glasses1.png';

  void _glasses1() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      glasses='images/glasses1.png';
    });}

  void _glasses2() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      glasses='images/glasses2.png';
    });
  }

  void _glasses3() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      glasses='images/glasses3.png';
    });
  }

  void _glasses4() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      glasses='images/glasses4.png';
    });
  }

  void _glasses5() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      glasses='images/glasses5.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
            new Stack(
                children: <Widget>[Image.asset('images/poo.png'),
                  new Positioned(
                      top: 30.0,
                      right: 40.0,
                      child: Image.asset('$glasses',height: 50,width: 100)
                  ),
                ]
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _glasses2,
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:AssetImage('images/glasses2.png'),
                              fit:BoxFit.contain
                          )
                      ),
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _glasses1,
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:AssetImage('images/glasses1.png'),
                              fit:BoxFit.contain
                          )
                      ),
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _glasses3,
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:AssetImage('images/glasses3.png'),
                              fit:BoxFit.contain
                          )
                      ),
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _glasses4,
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:AssetImage('images/glasses4.png'),
                              fit:BoxFit.contain
                          )
                      ),
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _glasses5,
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:AssetImage('images/glasses5.png'),
                              fit:BoxFit.contain
                          )
                      ),
                    ),
                  ),

                ]))
          ],
        ),
      ),
    );

  }
}
