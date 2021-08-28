library authantication;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Avatar/avatar.dart';
/*
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("THIS IS HOME"),
      ),
    );
  }
}
*/


/// This is the main application widget.
class Instructions extends StatelessWidget {
  const Instructions({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        body: const _MyStatelessWidget(),

      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: const <Widget>[
        Center(
          child: Text('שלום!'),
        ),
        Center(
          child: Text('זה אפליקציה שתתקן לך חרדה'),
        ),
        Center(
          child: Text('ביי!'),
        )
      ],
    );
  }
}
